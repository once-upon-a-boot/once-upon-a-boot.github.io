./index.sh  > docs/index.html
rsync -av ../perfetto/out/ui/ui/dist/ docs/perfetto/
# set default timestamp view to Milliseconds
sed -i -e 's/defaultValue: timeline_1.TimestampFormat.Timecode,/defaultValue: timeline_1.TimestampFormat.Milliseconds,/'  ./docs/perfetto/v*/frontend_bundle.js
