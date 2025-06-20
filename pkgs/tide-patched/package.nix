{fishPlugins}: fishPlugins.tide.overrideAttrs {
  pname = "tide-patched";

  patches = [ ./no-newline-bind.patch ];
}
