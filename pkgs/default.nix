{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: let
    inherit (pkgs) callPackage;

    mkPackage = path: callPackage path {};
    mkMpvScript = path: pkgs.mpvScripts.callPackage path {};

    packages = {
      bencode-pretty = mkPackage ./bencode-pretty.nix;
      starship-patched = mkPackage ./starship-patched.nix;
      alacritty-sixel = mkPackage ./alacritty-sixel.nix;
      swayimg-git = mkPackage ./swayimg-git.nix;
      lix-patched = callPackage ./lix-patched.nix {inherit inputs;};
      comma-patched = mkPackage ./comma-patched.nix;
      nom-patched = mkPackage ./nom-patched.nix;
      nh-patched = callPackage ./nh-patched.nix {inherit self;};
      fish-patched = callPackage ./fish-patched.nix {fish = packages.fish-git;};
      bibata-hyprcursor = mkPackage ./bibata-hyprcursor;
      coreutils-full-patched = mkPackage ./coreutils-full-patched.nix;
      sway-unwrapped-git = mkPackage ./sway-unwrapped-git;
      fish-git = mkPackage ./fish-git.nix;
      jellyfin-intro-skipper = mkPackage ./jellyfin-intro-skipper.nix;
      file-roller-gtk3 = mkPackage ./file-roller-gtk3.nix;
      git-clean = mkPackage ./git-clean.nix;
      direnv-patched = mkPackage ./direnv-patched.nix;

      # mpvScripts
      simple-undo = mkMpvScript ./mpvScripts/simple-undo.nix;
      skip-to-silence = mkMpvScript ./mpvScripts/skip-to-silence.nix;
    };
  in {
    # garnix doesn't support legacyPackages
    inherit packages;
  };
}
