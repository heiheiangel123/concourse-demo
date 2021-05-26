#!/bin/bash

#echo $varsfile

if [ -f "foundation-env-source/values.sh" ]; then
  cd foundation-env-source
  sh values.sh $project $initvars
  cd -
fi

/root/rgtpl -s /home/azureuser/learn-concourse-demo/pipelines/template -d /home/azureuser/learn-concourse-demo/pipelines/ -f /home/azureuser/learn-concourse-demo/pipelines/config/values.yaml

ls -Rl /home/azureuser/learn-concourse-demo/pipelines
#cat master-pipeline/*

