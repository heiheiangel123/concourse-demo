cat params.yaml
/root/rgtpl -s values.template -d values.yaml -f params.yaml -k invalid
cat values.yaml
