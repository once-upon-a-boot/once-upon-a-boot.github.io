- git clone https://github.com/google/perfetto
  tools/install-build-deps --ui 
  ui/build
  ls out/ui/ui/dist

How to set by default ns timestamp?

  sed -i -e '/TimestampFormat."Timecode"/d' docs/perfetto/v53.0-6d07acaaf/frontend_bundle.js

perfetto use URL Startup commands to add a pin on timestamp + expand all lines

- close Perfetto left Panel by default
- add URL startup command to perfetto to show pin for current time
- perfetto set default timestamp to timeNs
- show timestamp on log when selected

Files packaging: trace.sh, get realpath to binaries to use canonical path to
reference source code in output

Solve automatic focus on perfetto window after clicking button

Add W-A-S-D tutorial at the top
