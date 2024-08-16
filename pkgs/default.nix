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
      starship-patched = mkPackage ./starship-patched.nix;
      alacritty-sixel = mkPackage ./alacritty-sixel.nix;
      swayimg-git = mkPackage ./swayimg-git.nix;
      lix-patched = mkPackage ./lix-patched.nix;
      comma-patched = mkPackage ./comma-patched.nix;
      nom-patched = mkPackage ./nom-patched.nix;
      nh-patched = callPackage ./nh-patched.nix {inherit self;};
      fish-patched = mkPackage ./fish-patched.nix;
      bibata-hyprcursor = mkPackage ./bibata-hyprcursor;
      coreutils-full-patched = mkPackage ./coreutils-full-patched.nix;
      sway-unwrapped-git = mkPackage ./sway-unwrapped-git;

      # mpvScripts
      simple-undo = mkMpvScript ./mpvScripts/simple-undo.nix;
      skip-to-silence = mkMpvScript ./mpvScripts/skip-to-silence.nix;

      # vimPlugins
      direnv-nvim = mkVimPlugin ./vimPlugins/direnv-nvim.nix;
      neozoom-lua = mkVimPlugin ./vimPlugins/neozoom-lua.nix;
      bufresize-nvim = mkVimPlugin ./vimPlugins/bufresize-nvim.nix;
      fastaction-nvim = mkVimPlugin ./vimPlugins/fastaction-nvim.nix;
    };
  };
}
