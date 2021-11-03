#!/bin/bash

export RESOURCE_GROUP_NAME=ebook-tutorial 
export STORAGE_ACCOUNT_NAME=ebooktfstate
export CONTAINER_NAME=tfstate
export KEY_VAULT=ebook

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
export ARM_ACCESS_KEY=$ACCOUNT_KEY


az keyvault create --name $KEY_VAULT --resource-group $RESOURCE_GROUP_NAME --location "EastUS"

az keyvault secret set --vault-name $KEY_VAULT --name "terraform-backend-key" --value $ARM_ACCESS_KEY

#export ARM_ACCESS_KEY=$(az keyvault secret show --name terraform-backend-key --vault-name $KEY_VAULT --query value -o tsv)