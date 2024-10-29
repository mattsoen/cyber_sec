# Documentation for Azure SQL Database Bicep Template

## Overview
This Bicep template provisions an Azure SQL logical server and a SQL Database within a specified resource group. It utilizes Azure Key Vault to securely retrieve the administrator password.

## Script Details

### Parameters
- **`serverName`**: The name of the SQL logical server. *(Type: string, Default: unique string generated based on resource group ID)*
- **`sqlDBName`**: The name of the SQL Database. *(Type: string, Default: 'SampleDB')*
- **`location`**: Location for all resources. *(Type: string, Default: resource group location)*
- **`administratorLogin`**: The administrator username of the SQL logical server. *(Type: string)*
- **`keyVaultSecretName`**: The Key Vault secret name for the administrator password. *(Type: string)*

### Variables
- **`skuName`**: The SKU name for the SQL Database. *(Value: 'Standard')*
- **`skuTier`**: The SKU tier for the SQL Database. *(Value: 'Standard')*

### Resources
1. **SQL Logical Server**
   - **Resource Type**: `Microsoft.Sql/servers`
   - **API Version**: `2022-05-01-preview`
   - **Name**: Set to the value of `serverName`.
   - **Properties**:
     - **Administrator Login**: Set to the value of `administratorLogin`.
     - **Administrator Login Password**: Retrieved securely from Azure Key Vault using `keyVaultSecretName`.

2. **SQL Database**
   - **Resource Type**: `Microsoft.Sql/servers/databases`
   - **API Version**: `2022-05-01-preview`
   - **Parent Resource**: SQL logical server.
   - **Name**: Set to the value of `sqlDBName`.
   - **Location**: Set to the value of `location`.
   - **SKU**:
     - **Name**: Set to `skuName`.
     - **Tier**: Set to `skuTier`.

### Outputs
- **`sqlServerId`**: The resource ID of the SQL logical server.
- **`sqlDBId`**: The resource ID of the SQL Database.

## How to Deploy
1. **Prerequisites**: Ensure you have the Azure CLI or Azure PowerShell installed and are authenticated to your Azure account.
2. **Deployment**:
   - Use the following command to deploy the Bicep template:
     ```bash
     az deployment group create --resource-group <your-resource-group> --template-file <path-to-your-bicep-file>.bicep
     ```
3. **Parameters**: You can pass parameters directly in the command line or use a parameters file.

## Customization
- **Server Name**: Modify the `serverName` parameter to customize the SQL logical server's name.
- **Database Name**: Change the `sqlDBName` parameter to set a different name for the SQL Database.
- **SKU Settings**: Adjust `skuName` and `skuTier` to customize the performance tier of the SQL Database.
- **Key Vault Integration**: Ensure that the Azure Key Vault is properly configured and that the specified secret exists.

## Notes
- Ensure that the specified Key Vault and secret have appropriate permissions for the deployment.
- The `administratorLogin` should follow Azure's naming conventions for SQL Server logins.

## License
This template is provided under the MIT License. See the root LICENSE file for details.
