#!/bin/bash
#  Description:
#  This script import bootstrap pipeline c-815 to concourse (bootstrap environment).
#
#
set -x
conCounrsePipeLineName="/home/azureuser/learn-concourse-demo/pipelines/BOOTSTRAP-master.yaml"
varFile="/home/azureuser/learn-concourse-demo/pipelines/config/vars.yaml"


#add bootstrp pipeline to concourse
sudo fly --target bts login -k --concourse-url ${concourseUrl} -n ${concourseTeam} --username ${concourseUserName} --password ${concoursePassWord}
sudo fly --target bts sp -p c-815-bootstrap -n -c ${conCounrsePipeLineName} 
sudo fly --target bts up -p c-815-bootstrap
sudo fly --target bts tj -j c-815-bootstrap/create_service_pipeline
sudo fly --target bts logout
