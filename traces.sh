#!/usr/bin/env bash

set -euo pipefail

if [ -z "${DISABLE_CONTAINER_CHECK:-}" ]; then
    ./container.sh $0 "$@"
    exit 0
fi

input()
{
    cat uftrace.data/exec.log | cut -f 1 -d ' ' | grep '^[0-9]' || true
}

start=$(input | head -n 1)
start=$(python3 -c "print(int($start))")
end=$(input | tail -n 1)
end=$(python3 -c "print(int($end) + 1)")

rm -rf traces/
mkdir -p traces/

for ts in $(seq $start $end); do
    range=$(python3 -c "print(str($ts - 0.2) + '~' + str($ts + 1.2))")
    here="$(pwd)/"
    url="https://github.com/once-upon-a-boot/code/blob/main/"
    # srcline requires recent uftrace
    regex='s@%s\(.*\):@%s\\1#L@\'
    cmd='uftrace dump --chrome --srcline --time-range=%s | sed -e '"'$regex'"' | gzip -9 > traces/%s.gz\n'
    printf "$cmd" "$range" "$here" "$url" "$ts"
done | parallel -j $(nproc) --bar

du -h traces/
