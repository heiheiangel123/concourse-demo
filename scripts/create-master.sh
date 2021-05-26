#!/bin/bash

mkdir master-pipeline
#echo $varsfile

if [ -f "master-source/scripts/values.sh" ]; then
  cd master-source
  sh values.sh $project $initvars
  cd -
fi

/root/rgtpl -s master-source/template -d master-pipeline -f foundation-env-source/values.yaml

ls -Rl master-pipeline

cat master-pipeline/*

