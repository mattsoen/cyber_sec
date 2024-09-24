# Documentation for GCP Network and Firewall Script

## Overview
This script creates a Google Cloud Platform (GCP) network and a firewall rule. It is designed to help set up basic network infrastructure within a specified GCP project and region.

## Script Details

### Locals
- `name_suffix`: A suffix added to resource names for easier identification. Currently set to `"example"`.

### Variables
- `project_id`: The ID of the GCP project where resources will be created. *(Type: string)*
- `region`: The GCP region where the network will be deployed. *(Type: string)*

### Resources
1. **Google Compute Network**
   - **Resource Name**: `google_compute_network.default`
   - **Description**: Creates a VPC network.
   - **Name Format**: `test-network-example-{region}`

2. **Google Compute Firewall**
   - **Resource Name**: `google_compute_firewall.default`
   - **Description**: Configures a firewall rule allowing specific inbound traffic.
   - **Name Format**: `test-firewall-example`
   - **Direction**: `INGRESS`
   - **Priority**: `1000`
   - **Allowed Protocols and Ports**:
     - `icmp`
     - `tcp` on ports `80`, `8080`, and `1000-2000`
   - **Source Ranges**: Restricts access to the IP range `192.168.1.0/24`.

## How to Run
1. **Prerequisites**: Ensure you have Terraform installed and configured with access to your GCP account.
2. **Initialization**:
   - Run `terraform init` to initialize the configuration.
3. **Configuration**:
   - Modify the `project_id` and `region` variables in your Terraform configuration file as needed.
4. **Apply**:
   - Run `terraform apply` to create the network and firewall resources.

## Customization
- **Name Suffix**: Change the `name_suffix` in the `locals` block to customize the resource names.
- **Firewall Rules**: Modify the `allow` blocks within the `google_compute_firewall` resource to adjust allowed protocols and ports.
- **Source Ranges**: Update the `source_ranges` value to change the allowed IP ranges for incoming traffic.

## Notes
- Ensure that the specified `project_id` and `region` are valid in your GCP account.
- Be mindful of the firewall rules to avoid unintentional exposure of services. 

## License
This script is provided under the MIT License. See the root LICENSE file for details.
