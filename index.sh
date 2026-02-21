#!/usr/bin/env bash

set -euo pipefail

content()
{
    id=0
    cat ./exec.log | while read line; do
        ts=$(echo $line | cut -f 1 -d ' ')
        ts_us=$(echo $ts | sed -e 's/\.//')
        ts_ns=$(( ts_us * 1000 ))
        out=$(echo $line | cut -f 2- -d ' ')
        trace_name=$(echo $ts | cut -f 1 -d '.')
        trace_url=https://raw.githubusercontent.com/once-upon-a-boot/traces/main/$trace_name.gz
        start=$(( ts_ns - 100000 ))
        end=$(( ts_ns + 100000 ))
        label=$(echo $line | cut -f 2- -d ' ' | tr "\`" ' ')
        cat << EOF
<button id="select_$id" class="output" onclick="trace('select_$id', '$ts_us', \`$label\`, '$trace_url', 'visStart=$start&visEnd=$end&ts=$ts_ns')">+</button>$out
EOF
        id=$((id + 1))
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
    height: 97vh;
    position: static;
    overflow-y: auto;
    overflow-x: auto;
    margin: 0px;
    padding: 0px;
}
.viewer
{
    height: 97vh;
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
var selected;
function trace(selection, ts_us, ts_label, url, parameters) {
viewer = document.getElementById('perfetto');
b = document.getElementById(selection);
if (selected) {
    selected.style='';
}
b.style='background-color:red';
selected = b;

const commands = [
{
 'id': 'dev.perfetto.ExpandTracksByRegex',
 'args': ['.*']
},
{
 'id': 'dev.perfetto.AddNote',
 'args': [ts_us.toString(), ts_label, '#ff2222']
},
{
 'id': 'dev.perfetto.SetTimestampFormat',
 'args': ['Milliseconds']
},
{
 'id': 'dev.perfetto.ToggleLeftSidebar',
 'args': []
},
];

const startup_commands = encodeURIComponent(JSON.stringify(commands));
viewer.src = 'perfetto/#!/?url=' + url + '&' + parameters + '&startupCommands=' + startup_commands;
viewer.contentWindow.location.reload();
viewer.focus();
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
