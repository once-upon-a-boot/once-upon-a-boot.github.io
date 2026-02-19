#!/usr/bin/env bash

set -euo pipefail

input()
{
    cat uftrace.data/exec.log | cut -f 1 -d ' ' | grep '^[0-9]'
}

start=$(input | head -n 1)
start=$(python -c "print(int($start))")
end=$(input | tail -n 1)
end=$(python -c "print(int($end) + 1)")

rm -rf traces/
mkdir -p traces/

for ts in $(seq $start $end); do
    range=$(python3 -c "print(str($ts - 0.2) + '~' + str($ts + 1.2))")
    printf "uftrace dump --chrome --srcline --time-range=$range | gzip -9 > traces/$ts.gz\n";
done | parallel -j $(nproc) --bar
