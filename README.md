- tools/install-build-deps --ui && ui/build && ls out/ui/ui/dist
- ui/run-unittests
- ui/run-integrationtests --rebaseline --no-docker

TODO:
- add all files for every subrepo + copy licenses
- add timestamps for all other lines on existing traces, and color in red
  current one
- limit other timestamps to current visible trace to avoid long URL
- missing W + S navigation?
