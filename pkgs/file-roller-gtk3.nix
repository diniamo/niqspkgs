{
  lib,
  stdenv,
  fetchurl,
  desktop-file-utils,
  gettext,
  glibcLocales,
  itstool,
  libxml2,
  meson,
  ninja,
  pkg-config,
  python3,
  wrapGAppsHook,
  cpio,
  glib,
  gnome,
  gtk3,
  libhandy,
  json-glib,
  libarchive,
  libportal-gtk3,
  # nautilus,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "file-roller";
  version = "43.1";

  src = fetchurl {
    url = "mirror://gnome/sources/file-roller/${lib.versions.major finalAttrs.version}/file-roller-${finalAttrs.version}.tar.xz";
    sha256 = "hJlAI5lyk76zRdl5Pbj18Lu0H6oVXG/7SDKPIDlXrQg=";
  };

  nativeBuildInputs = [
    desktop-file-utils
    gettext
    glibcLocales
    itstool
    libxml2
    meson
    ninja
    pkg-config
    python3
    wrapGAppsHook
  ];

  buildInputs = [
    cpio
    glib
    gtk3
    libhandy
    json-glib
    libarchive
    libportal-gtk3
    # nautilus
  ];

  mesonFlags = [(lib.mesonEnable "nautilus-actions" false)];

  postPatch = ''
    patchShebangs data/set-mime-type-entry.py
  '';

  passthru = {
    updateScript = gnome.updateScript {
      packageName = "file-roller";
      attrPath = "gnome.file-roller";
    };
  };
})
