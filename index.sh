#!/usr/bin/env bash

set -euo pipefail

content()
{
    cat ./exec.log | while read line; do
        ts=$(echo $line | cut -f 1 -d ' ')
        ts_ms=$(echo $ts | sed -e 's/\.//')
        ts_ns=$(( ts_ms * 1000 ))
        out=$(echo $line | cut -f 2- -d ' ')
        trace_name=$(echo $ts | cut -f 1 -d '.')
        trace_url=https://raw.githubusercontent.com/once-upon-a-boot/traces/main/$trace_name.gz
        start=$(( ts_ns - 10 ))
        end=$(( ts_ns + 1000 ))
        cat << EOF
<button class="output" onclick="trace('$trace_url', 'visStart=$start&visEnd=$end&ts=$ts_ns')">+</button>$out
EOF
    done
}

cat << EOF
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<style>
.left
{
    position: static;
    padding: 0px;
    margin: 0px;
}

.right
{
    height: 95vh;
    position: static;
    overflow-y: auto;
    overflow-x: auto;
    margin: 0px;
    padding: 0px;
}
.viewer
{
    height: 95vh;
    width:70vw;
    margin: 0px;
    padding: 0px;
}
.output
{
    margin: 0px;
    padding: 0px;
}
</style>
<script>
function trace(url, parameters) {
viewer = document.getElementById('perfetto');
viewer.src = 'perfetto/#!/?url=' + url + '&' + parameters;
viewer.contentWindow.location.reload();
}
</script>
</head>

<body>
<div style="display: flex">
<div class="left">
<iframe class="viewer" id="perfetto" src="perfetto/#!/"></iframe>
</div>
<div class="right">
<pre>
$(content)
</pre>
</div>
</div>
</body>
EOF
