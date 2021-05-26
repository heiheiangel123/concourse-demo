#!/bin/bash
ls -Rl
cd master-source/${package}/${servicename}
cat <<EOF > provider_auth.tf
provider "azurerm" {
  version = "~> 1.23"
  use_msi = true
  environment  =  "china"
  subscription_id =  "${subscription_id}"
  tenant_id =  "${tenant_id}"
}
EOF
if [ -f "provider_gs.tf" ]; then
cat <<EOF > provider_gs.tf
  provider "azurerm" {
    alias  = "gs"
    version = "~> 1.23"
    use_msi = true
    environment  =  "china"
    subscription_id =  "${gs_subscription_id}"
    tenant_id =  "${tenant_id}"
  }
EOF
fi

cat <<BACKEND > backend.tf
terraform {
  backend "azurerm" {
    resource_group_name  = "${azure_storage_rg}"
    storage_account_name = "${azure_storage_account}"
    container_name       = "tfstate"
    key                  = "${environment}/${servicename}-${environment}.tfstate"
    access_key          = "${azure_storage_accesskey}"
    environment  =  "china"
  }
}
BACKEND
echo "terraform source"
ls -al
mv /opt/.terraform ./

#export AWS_ACCESS_KEY_ID=$access_key
#export AWS_SECRET_ACCESS_KEY=$secret_key
terraform init #-backend-config key=etcd -backend-config path=/terraform/ -backend-config  endpoints=http://10.231.96.211:2379
#terraform plan  -var-file=../../../${servicename}/values.tfvars
terraform apply -var-file=../../../${servicename}/values.tfvars -auto-approve

