#!/bin/bash

mkdir master-pipeline
#echo $varsfile

if [ -f "foundation-env-source/values.sh" ]; then
  cd foundation-env-source
  sh values.sh $project $initvars
  cd -
fi

/root/rgtpl -s master-source/template -d master-pipeline -f foundation-env-source/values.yaml

ls -Rl /home/azureuser/learn-concourse-demo/pipelines
cat master-pipeline/*

