This repository contains a collection of reusable IaC scripts and templates designed to automate the provisioning and management of cloud infrastructure.

## Overview
This directory features various IaC configurations. Each script is designed to be modular and adaptable, enabling you to easily customize them for your own projects.

## Prerequisites
Ensure Terraform is installed (for Terraform scripts)
Azure subscription (for Bicep scripts)

## License
This project is licensed under the MIT License.

## Documentation
Each file has an associated .md file outlining key details for reference. 

## Files
**gcp_network.tf** - This provisions a GCP network and basic firewall rules. This is based on learnings from the Google Cloud Cybersecurity Professional course.

**gcp_storage_bucket.tf** - This provisions a GCP storage bucket and pub/sub topic. This is based on learnings from the Google Cloud Cybersecurity Professional course.

**az_sql_db.bicep** - This securely provisions an Azure SQL Server database. This is based on learnings from the Azure Security Engineer course.

**az_storage.bicep** - This securely provisions an Azure Storage account. This is based on learnings from the Azure Security Engineer course.
