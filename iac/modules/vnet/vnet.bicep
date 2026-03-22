@description('Name of the Virtual Network')
param vnetName string

@description('Azure region')
param location string

@description('VNet address space')
param addressSpace string

@description('AKS Subnet CIDR')
param aksSubnetPrefix string

@description('ApplicationGateway subnet CIDR')
param applicationGatewayprefix string

@description('DB subnet CIDR')
param dbSubnetPrefix string

@description('AKS NSG ID')
param aksNsgId string = ''

@description('app gateway NSG ID')
param appgwNsgId string = ''

@description('db NSG ID')
param dbNsgId string = ''

@description('tags')
param tags object = {}

resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
    name: vnetName
    location: location
    tags: tags
    properties: {
        addressSpace:{
            addressPrefixes: [
                addressSpace
            ]
        }
    }
}

resource aksSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-05-01' = {
    name: 'aks-subnet'
    parent: vnet
    properties: {addressPrefix:aksSubnetPrefix 
        networkSecurityGroup: aksNsgId != '' ? {id: aksNsgId} : null}
}

resource appgwSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-05-01' = {
    name: 'app-gw-subnet'
    parent: vnet
    properties: {addressPrefix: applicationGatewayprefix 
        networkSecurityGroup: appgwNsgId != ''? {id: appgwNsgId } : null}
}

resource dbSubnet 'Microsoft.Network/virtualNetworks/subnets@2023-05-01' = {
    name: 'db-subnet'
    parent: vnet
    properties:{
        addressPrefix: dbSubnetPrefix 
            networkSecurityGroup: dbNsgId != ''? {id: dbNsgId } : null} 
}

output vnetId string = vnet.id
output aksSubnetId string = aksSubnet.id
output appgwSubnet string = aksSubnet.id
output dbSubnet string = dbSubnet.id
output vnetName string = vnet.name
