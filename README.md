- git clone https://github.com/google/perfetto
  tools/install-build-deps --ui 
  ui/build
  ls out/ui/ui/dist

  sed -i -e '/TimestampFormat."Timecode"/d' docs/perfetto/v53.0-6d07acaaf/frontend_bundle.js
