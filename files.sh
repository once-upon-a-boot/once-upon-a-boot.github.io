#!/usr/bin/env bash

set -euo pipefail

# TODO:
# all files with .c .h and .s inside + all sources referenced in trace + git ls-files + ignored files .c .h .s
#

cat uftrace.data/*.dbg | grep '^L:' | cut -f 3- -d ' ' | sort -u | grep ^/ | sed -e "s#$(pwd)/##" |
    tar cvf files.tar -T -
