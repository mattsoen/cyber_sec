@description('The name of the SQL logical server.')
param serverName string = uniqueString('sql', resourceGroup().id)

@description('The name of the SQL Database.')
param sqlDBName string = 'SampleDB'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('The administrator username of the SQL logical server.')
param administratorLogin string

@description('The Key Vault secret name for the administrator password.')
param keyVaultSecretName string

// Variable for SKU settings
var skuName = 'Standard'
var skuTier = 'Standard'

// Reference to retrieve the administrator password from Azure Key Vault
@secure()
var administratorLoginPassword = list(secretUri: 'https://<your-key-vault-name>.vault.azure.net/secrets/${keyVaultSecretName}', apiVersion: '7.0').value

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}

resource sqlDB 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  name: sqlDBName
  parent: sqlServer
  location: location
  sku: {
    name: skuName
    tier: skuTier
  }
}

output sqlServerId string = sqlServer.id
output sqlDBId string = sqlDB.id
