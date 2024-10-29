# Documentation for Azure Storage Account Bicep Template

## Overview
This Bicep template provisions an Azure Storage Account within a specified resource group. It allows you to choose the storage account type and location.

## Script Details

### Parameters
- **`storageAccountType`**: The type of storage account. *(Type: string, Allowed Values: `Premium_LRS`, `Standard_LRS`, Default: `Standard_LRS`)*
- **`location`**: The storage account location. *(Type: string, Default: resource group location)*
- **`storageAccountName`**: The name of the storage account. *(Type: string)*

### Resources
1. **Storage Account**
   - **Resource Type**: `Microsoft.Storage/storageAccounts`
   - **API Version**: `2022-09-01`
   - **Name**: Set to the value of `storageAccountName`.
   - **Location**: Set to the value of `location`.
   - **SKU**:
     - **Name**: Set to the value of `storageAccountType`.
   - **Kind**: `'StorageV2'`.
   - **Properties**: Empty object (no additional properties set).

### Outputs
- **`storageAccountNameOutput`**: The name of the storage account.
- **`storageAccountId`**: The resource ID of the storage account.

## How to Deploy
1. **Prerequisites**: Ensure you have the Azure CLI or Azure PowerShell installed and are authenticated to your Azure account.
2. **Deployment**:
   - Use the following command to deploy the Bicep template:
     ```bash
     az deployment group create --resource-group <your-resource-group> --template-file <path-to-your-bicep-file>.bicep
     ```
3. **Parameters**: You can pass parameters directly in the command line or use a parameters file.

## Customisation
- **Storage Account Type**: Modify the `storageAccountType` parameter to select either `Premium_LRS` or `Standard_LRS`.
- **Storage Account Name**: Set the `storageAccountName` parameter to customise the name of your storage account.
- **Location**: Change the `location` parameter to deploy the storage account in a different Azure region if needed.

## Notes
- Ensure that the specified `storageAccountName` follows Azure's naming conventions for storage accounts (e.g., lowercase, 3-24 characters).
- The chosen storage account type may affect pricing and performance characteristics.

## License
This template is provided under the MIT License. See the root LICENSE file for details.
