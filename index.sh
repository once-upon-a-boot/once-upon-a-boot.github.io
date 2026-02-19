#!/usr/bin/env bash

set -euo pipefail

content()
{
    cat ./exec.log | while read line; do
        ts=$(echo $line | cut -f 1 -d ' ')
        out=$(echo $line | cut -f 2- -d ' ')
        trace_name=$(echo $ts | cut -f 1 -d '.')
        trace_url=https://raw.githubusercontent.com/once-upon-a-boot/traces/main/$trace_name.gz
        perfetto_url="perfetto/#!/?url=$trace_url"
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
