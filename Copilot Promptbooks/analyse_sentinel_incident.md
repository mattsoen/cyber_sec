# Documentation for Analyse Microsoft Sentinel Incident Promptbook Template

## Overview
This promptbook generates a report about a specific incident in Microsoft Sentinel, along with related alerts, reputation scores, users, and devices.

## Template Details

### Tags
- **`Sentinel`**
- **`Incident`**

### Inputs
- **`SENTINEL_INCIDENT_ID`**: The ID of the incident in Microsoft Sentinel. *(Type: string)*

### Plugins
- **`Microsoft Defender XDR`**
- **`Microsoft Sentinel`**

## Prompts

1. **Incident Details**  
   Please summarise the details of Sentinel incident `<SENTINEL_INCIDENT_ID>`.

2. **Associated Entities**  
   What entities are associated with this incident?

3. **Reputation Scores**  
   What are the reputation scores for the IP addresses linked to this incident?

4. **Authentication Methods**  
   What authentication methods are configured for each user involved in this incident? Specifically, indicate whether they have Multi-Factor Authentication (MFA) enabled.

5. **User Devices**  
   For any users listed in the incident details, show the devices they have used recently and indicate their compliance status with company policies.

6. **Intune Device Details**  
   From the devices mentioned earlier, provide details from Intune for the one that checked in most recently, particularly regarding its operating system update status.

7. **Executive Summary**  
   Draft an executive summary report of this investigation tailored for a non-technical audience.

## How to Run
1. **Prerequisites**: Ensure that you have appropriate access to run the promptbook and access to the required data sources.
2. **Inputs**: You can pass inputs directly at runtime.

## Customisation
- **PROMPTS**: Modify the wording of the prompts to suit your reporting format or analysis needs.

## License
This template is provided under the MIT License. See the root LICENSE file for details.
