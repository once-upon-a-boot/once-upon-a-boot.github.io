#!/usr/bin/env bash

set -euo pipefail

content()
{
    cat ./exec.log | while read line; do
        ts=$(echo $line | cut -f 1 -d ' ')
        ts_ns=$(echo $ts | sed -e 's/\.//')
        out=$(echo $line | cut -f 2- -d ' ')
        trace_name=$(echo $ts | cut -f 1 -d '.')
        trace_url=https://raw.githubusercontent.com/once-upon-a-boot/traces/main/$trace_name.gz
        start=$(( (ts_ns) * 1000 ))
        end=$(( (ts_ns + 10) * 1000 ))
        perfetto_url="perfetto/#!/?url=$trace_url&visStart=$start&visEnd=$end"
        echo "<a href="$perfetto_url">🔍</a> $out"
    done
}

cat << EOF
<body>
<pre>
$(content)
</pre>
</body>
EOF
