{self, ...}: {
  perSystem = {pkgs, ...}: let
    inherit (pkgs) callPackage;

    mkPackage = path: callPackage path {};
    mkMpvScript = path: pkgs.mpvScripts.callPackage path {};
    # There is also a buildNeovimPlugin function in nixpkgs
    # but the name is misleading, since it's only used for building plugins from existing lua packages
    mkVimPlugin = path: callPackage path {inherit (pkgs.vimUtils) buildVimPlugin;};
  in {
    # garnix doesn't support legacyPackages
    packages = {
      bencode-pretty = mkPackage ./bencode-pretty.nix;
      starship-nix3-shell = mkPackage ./starship-nix3-shell.nix;
      alacritty-sixel = mkPackage ./alacritty-sixel.nix;
      swayimg-git = mkPackage ./swayimg-git.nix;
      lix-default-flake = mkPackage ./lix-default-flake.nix;
      comma-sensible-print = mkPackage ./comma-sensible-print.nix;
      nom-traces-nf-icons = mkPackage ./nom-traces-icons.nix;
      nh-patched-nom = callPackage ./nh-patched-nom.nix {inherit self;};

      # nodePackages
      cbmp = mkPackage ./nodePackages/cbmp;

      # mpvScripts
      simple-undo = mkMpvScript ./mpvScripts/simple-undo.nix;
      skip-to-silence = mkMpvScript ./mpvScripts/skip-to-silence.nix;

      # vimPlugins
      direnv-nvim = mkVimPlugin ./vimPlugins/direnv-nvim.nix;
    };
  };
}
