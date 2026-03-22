targetScope= 'subscription'

@description('Name of the Resource Group')
param rgName string

@description('Azure region for the Resource Group')
param location string

@description('Tags for the Resource Group')
param tags object = {}

resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
	name: rgName
	location: location
	tags: tags
}

output resourceGroupName string = resourceGroup.name
output resourceGroupId string = resourceGroup.id
