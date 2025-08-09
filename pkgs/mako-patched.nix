{mako}: mako.overrideAttrs {
  # Remove enabling zsh completions, enable fish completions
  mesonFlags = [
    "-Dsd-bus-provider=libsystemd"
    "-Dicons=enabled"
    "-Dman-pages=enabled"
    "-Dfish-completions=true"
  ];

  # Remove copying systemd service, remove dbus service
  postInstall = "rm -r $out/share/dbus-1";
}
