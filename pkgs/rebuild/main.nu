#!/usr/bin/env nu

def missing_error [name: string] {
  error make --unspanned {
    msg: $"No ($name) provided, and no default saved"
  }
}

def message [text: string] {
  print $"(ansi green)>(ansi reset) ($text)"
}

def main [
  profile?: string
  --save-default (-s)
  --flake (-f): path
  --hostname (-h): string
  --remote (-r): string
] {
  let data_dir = $env.XDG_DATA_HOME? | default $"($env.HOME)/.local/share"
  let cache_path = $"($data_dir)/rebuild-profiles.nuon"

  let cache = if ($cache_path | path exists) { open $cache_path } else { {} }

  let resolved_profile = $profile | default $cache.default?
  if $resolved_profile == null { missing_error "profile" }
  
  mut profile_data = $cache | get --ignore-errors $resolved_profile | default {}

  if $flake != null { $profile_data.flake = $flake }
  if $hostname != null { $profile_data.hostname = $hostname }
  if $remote != null { $profile_data.remote = $remote }

  $cache | upsert "default" $resolved_profile
         | upsert $resolved_profile $profile_data
         | save --force $cache_path

  if not ("flake" in $profile_data) { missing_error "flake" }
  if not ("hostname" in $profile_data) { missing_error "hostname" }

  message "Building NixOS configuration"

  let store_path = (
    nix build
      --log-format internal-json --verbose
      --no-link --print-out-paths
      $"($profile_data.flake)#nixosConfigurations.($profile_data.hostname).config.system.build.toplevel"
    | tee --stderr { nom --json }
    | complete
    | get stdout
    | str trim --char "\n" --right
  )

  let remote = $profile_data.remote?
  if $remote == null {
    message "Comparing changes"
    nvd diff /run/current-system $store_path
    message "Activating configuration"
    sudo $"($store_path)/bin/switch-to-configuration" switch
  } else {
    let password = input --suppress-output $"\(($remote)\) Password: "
    print --no-newline "\n"
    
    let script_path = mktemp --tmpdir-path ($env.TMPDIR? | default "/tmp")
    $"#!/bin/sh\necho -n '($password)'" > $script_path
    chmod +x $script_path

    do {
      $env.SSH_ASKPASS = $script_path
      $env.SSH_ASKPASS_REQUIRE = "force"

      message $"Copying configuration to ($remote)"
      nix copy --to $"ssh-ng://($remote)" $store_path
      message $"Activating configuration on ($remote)"
      $password | ssh $remote $"sudo --prompt='' --stdin ($store_path)/bin/switch-to-configuration switch"
    }

    rm $script_path
  }
}
