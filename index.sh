#!/usr/bin/env bash

set -euo pipefail

content()
{
    cat ./exec.log | while read line; do
    ts=$(cut -f 1 -d ' ')
    out=$(cut -f 2- -d ' ')
    trace_name=$(echo $ts | cut -f 1 -d '.')
    echo $trace_name $out
    done
}

cat << EOF
<body>
$(content)
</body>
EOF
