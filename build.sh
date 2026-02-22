./index.sh  > docs/index.html
rsync -av --delete-after ../perfetto/out/ui/ui/dist/ docs/perfetto/
