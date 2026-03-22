@description('Public IP name')
param pipName string

@description('Azure Region')
param location string

@description('tags')
param tags object = {}

@description('Allocation Method: Static or Dynamic')
@allowed([
  'Static' 
  'Dynamic'
])
param allocationMethod string = 'Static'

@description('SKU: Basic or Standard')
@allowed([
  'Basic'
  'Standard'
])
param sku string = 'Standard'

@description('DNS label (optional)')
param dnsLabel string = ''

resource publicIP 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: pipName
  location: location
  tags: tags
  sku: {
    name: sku
  }
  properties: {
    publicIPAllocationMethod: allocationMethod
    dnsSettings: dnsLabel != '' ? {
      domainNameLabel: dnsLabel
    } : null
  }
}

output publicIpId string = publicIP.id
output publicIpAddress string = publicIP.properties.ipAddress
