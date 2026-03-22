@description('NSG Name')
param nsgName string

@description ('Azure Region')
param location string

@description('Security rules for NSG')
param securityRules array

@description('tags')
param tags object = {}

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: nsgName
  location: location
  tags: tags
  properties: {
    securityRules: [
      for rule in securityRules: {
        name: rule.name
        properties: {
          priority:rule.priority
          direction: rule.direction
          access: rule.access
          protocol: rule.protocol
          sourcePortRange: rule.sourceportRange
          destinationPortRange: rule.destinationPortRange
          sourceAddressPrefix: rule.sourceAddressprefix
          destinationAddressPrefix: rule.destinationAdressPrefix
        }
      }
    ]
  }
}

output nsgId string = nsg.id
output nsgName string = nsg.name
