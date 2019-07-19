#!/bin/bash

resourceGroupName="cosmosdb"
location="westeurope"
accountName="mylaaz203cosmosdb"
databaseName="myDatabase"

az group create \
 -n $resourceGroupName \
 -l $location

# Create a SQL API Cosmos DB account with session consistency and multi-master enabled
az cosmosdb create \
 -g $resourceGroupName \
 --name $accountName \
 --kind GlobalDocumentDB \
 --locations "West Europe=0" "North Europe=1" \
 --default-consistency-level Strong \
 --enable-multiple-write-locations false \
 --enable-automatic-failover true

#Operation failed with status: 'BadRequest'. Details: Cannot create Strong consistency account with EnableMultipleWriteLocations enabled. ActivityId: 06c0a6e2-a970-11e9-be1b-8c8590318538, Microsoft.Azure.Documents.Common/2.5.1

# Create a database
az cosmosdb database create \
 -g $resourceGroupName \
 --name $accountName \
 --db-name $databaseName

# List account keys
az cosmosdb list-keys \
 --name $accountName \
 -g $resourceGroupName

# This command has been deprecated and will be removed in a future release. Use 'cosmosdb keys list' instead.

# List account connection strings
az cosmosdb list-connection-strings \
 --name $accountName \
 -g $resourceGroupName

az cosmosdb show \
 --name $accountName \
 -g $resourceGroupName \
 --query "documentEndpoint"

# Clean up
az group delete -y -g $resourceGroupName
