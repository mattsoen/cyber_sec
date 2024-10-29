@description('Storage Account type')
@allowed([
  'Premium_LRS'
  'Standard_LRS'
])
param storageAccountType string = 'Standard_LRS'

@description('The storage account location.')
param location string = resourceGroup().location

@description('The name of the storage account.')
param storageAccountName string

resource sa 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountType
  }
  kind: 'StorageV2'
  properties: {}
}

output storageAccountNameOutput string = storageAccountName
output storageAccountId string = sa.id
