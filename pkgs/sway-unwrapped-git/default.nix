{
  lib,
  stdenv,
  fetchFromGitHub,
  substituteAll,
  swaybg,
  meson,
  ninja,
  pkg-config,
  wayland-scanner,
  scdoc,
  libGL,
  wayland,
  libxkbcommon,
  pcre2,
  json_c,
  libevdev,
  pango,
  cairo,
  libinput,
  gdk-pixbuf,
  librsvg,
  wlroots,
  fetchFromGitLab,
  wayland-protocols,
  libdrm,
  # Used by the NixOS module:
  isNixOS ? false,
  xorg,
  systemdSupport ? lib.meta.availableOn stdenv.hostPlatform systemd,
  systemd,
  trayEnabled ? systemdSupport,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "sway-unwrapped";
  version = "2024-08-14";

  inherit isNixOS systemdSupport trayEnabled;
  src = fetchFromGitHub {
    owner = "swaywm";
    repo = "sway";
    rev = "c30c4519079e804c35e71810875c10f48097d230";
    hash = "sha256-/M5oq8bHnXm0eKacxyVMJuK+JPsnhUGw2qrXkzrB2D4=";
  };

  patches =
    [
      ./load-configuration-from-etc.patch

      (substituteAll {
        src = ./fix-paths.patch;
        inherit swaybg;
      })
    ]
    ++ lib.optionals (!finalAttrs.isNixOS) [
      # References to /nix/store/... will get GC'ed which causes problems when
      # copying the default configuration:
      ./sway-config-no-nix-store-references.patch
    ]
    ++ lib.optionals finalAttrs.isNixOS [
      # Use /run/current-system/sw/share and /etc instead of /nix/store
      # references:
      ./sway-config-nixos-paths.patch
    ];

  strictDeps = true;
  depsBuildBuild = [
    pkg-config
  ];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    wayland-scanner
    scdoc
  ];

  buildInputs =
    [
      libGL
      wayland
      libxkbcommon
      pcre2
      json_c
      libevdev
      pango
      cairo
      libinput
      gdk-pixbuf
      librsvg
      wayland-protocols
      libdrm
      (wlroots.overrideAttrs {
        version = "0.19.0";

        src = fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "wlroots";
          repo = "wlroots";
          rev = "e88988e364103ac0acd0da2e7642d5bf7fefd83e";
          hash = "sha256-3+eHemUbXC4vbrCS0kiWPQtvGI/9Xh9s6qYU3N/TPOA=";
        };
      })
    ]
    ++ lib.optionals wlroots.enableXWayland [
      xorg.xcbutilwm
    ];

  mesonFlags = let
    inherit (lib.strings) mesonEnable mesonOption;

    # The "sd-bus-provider" meson option does not include a "none" option,
    # but it is silently ignored iff "-Dtray=disabled".  We use "basu"
    # (which is not in nixpkgs) instead of "none" to alert us if this
    # changes: https://github.com/swaywm/sway/issues/6843#issuecomment-1047288761
    # assert trayEnabled -> systemdSupport && dbusSupport;

    sd-bus-provider =
      if systemdSupport
      then "libsystemd"
      else "basu";
  in [
    (mesonOption "sd-bus-provider" sd-bus-provider)
    (mesonEnable "tray" finalAttrs.trayEnabled)
  ];

  meta.mainProgram = "sway";
})
