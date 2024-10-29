# Documentation for Unusual Outbound Traffic KQL Script

## Overview
This KQL script analyses outbound traffic from Azure's Network Security Group operations. It identifies unusual outbound traffic destinations by comparing current traffic against a baseline of normal traffic.

## Script Details

### Query Breakdown
1. **Define Normal Outbound Traffic**:
   - **Source**: `AzureActivity`
   - **Filter**: 
     - `OperationName == "Network Security Group"` and `ActivityStatus == "Succeeded"`: Focuses on successful network security group activities.
   - **Summarisation**:
     - `summarize OutboundTraffic = count() by DestinationCountry`: Counts the outbound traffic to each destination country.
   - **Top Selection**:
     - `top 5 by OutboundTraffic`: Selects the top 5 destination countries with the highest outbound traffic.

2. **Identify Unusual Outbound Traffic**:
   - **Source**: `AzureActivity`
   - **Filter**: 
     - `OperationName == "Network Security Group"` and `ActivityStatus == "Succeeded"`: Again focuses on successful network security group activities.
   - **Summarisation**:
     - `summarize OutboundTraffic = count() by DestinationCountry`: Counts the outbound traffic to each destination country.
   - **Exclusion Filter**:
     - `where DestinationCountry !in (NormalOutboundTraffic.DestinationCountry)`: Filters out the countries identified as normal outbound traffic.
   - **Sorting**:
     - `order by OutboundTraffic desc`: Orders the results in descending order based on the count of outbound traffic.

### Output
- **Columns**:
  - **`DestinationCountry`**: The country to which outbound traffic is directed.
  - **`OutboundTraffic`**: The count of outbound traffic events to each destination country, excluding normal traffic.

## How to Execute
1. **Prerequisites**: Ensure you have access to a service that allows running KQL queries against AzureActivity logs.
2. **Execution**:
   - Copy and paste the following KQL script into your query editor:
     ```kql
     let NormalOutboundTraffic = AzureActivity
         | where OperationName == "Network Security Group" and ActivityStatus == "Succeeded"
         | summarize OutboundTraffic = count() by DestinationCountry
         | top 5 by OutboundTraffic;
     AzureActivity
     | where OperationName == "Network Security Group" and ActivityStatus == "Succeeded"
     | summarize OutboundTraffic = count() by DestinationCountry
     | where DestinationCountry !in (NormalOutboundTraffic.DestinationCountry)
     | order by OutboundTraffic desc
     ```
3. **Run the Query**: Execute the query to retrieve the results.

## Customisation
- **Normal Traffic Threshold**: Adjust the number of top countries in `top 5 by OutboundTraffic` to change the baseline for normal outbound traffic.
- **Operation Name**: Modify the `OperationName` filter to include other Azure activity types if needed.

## Notes
- Ensure that you have the necessary permissions to access AzureActivity logs and run queries.
- Review the definitions of `OperationName` and `ActivityStatus` to ensure they align with your organisation’s monitoring criteria.

## License
This KQL script is provided under the MIT License. See the root LICENSE file for details.
