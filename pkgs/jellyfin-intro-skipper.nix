{
  jellyfin,
  jellyfin-web,
}:
jellyfin.override {
  jellyfin-web = jellyfin-web.overrideAttrs {
    pname = "jellyfin-web-intro-skipper";
    postFixup = ''
      sed -i \
        "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script></head>#" \
        $out/share/jellyfin-web/index.html
    '';
  };
}
