# Documentation for Logon and Logoff Events KQL Script

## Overview
This KQL script analyses security events related to user logons and logoffs. It counts the number of logon events and matches them with corresponding logoff events for each account, providing insight into user activity.

## Script Details

### Query Breakdown
1. **Count Logon Events**:
   - **Source**: `SecurityEvent`
   - **Filter**: 
     - `EventID == "4624"`: Focuses on successful logon events.
   - **Summarisation**:
     - `summarize LogOnCount=count() by EventID, Account`: Counts the total successful logon events for each account.
   - **Projection**:
     - `project LogOnCount, Account`: Selects the relevant columns for output.

2. **Count Logoff Events**:
   - **Source**: `SecurityEvent`
   - **Filter**:
     - `EventID == "4634"`: Focuses on logoff events.
   - **Summarisation**:
     - `summarize LogOffCount=count() by EventID, Account`: Counts the total logoff events for each account.
   - **Projection**:
     - `project LogOffCount, Account`: Selects the relevant columns for output.

3. **Join Logon and Logoff Counts**:
   - **Join Operation**:
     - `join kind=inner`: Combines the logon and logoff counts based on the account.

### Output
- **Columns**:
  - **`LogOnCount`**: The total number of successful logon events for each account.
  - **`Account`**: The username or account identifier.
  - **`LogOffCount`**: The total number of logoff events for each account (included as part of the join).

## How to Execute
1. **Prerequisites**: Ensure you have access to a service that allows running KQL queries against SecurityEvent logs.
2. **Execution**:
   - Copy and paste the following KQL script into your query editor:
     ```kql
     SecurityEvent 
     | where EventID == "4624" 
     | summarize LogOnCount=count() by EventID, Account 
     | project LogOnCount, Account 
     | join kind = inner (
          SecurityEvent 
          | where EventID == "4634" 
          | summarize LogOffCount=count() by EventID, Account 
          | project LogOffCount, Account 
     ) on Account
     ```
3. **Run the Query**: Execute the query to retrieve the results.

## Customisation
- **Event IDs**: Modify the `EventID` filters if you need to analyse other types of logon or logoff events.
- **Aggregation**: You can further summarise or group results by additional fields if required.

## Notes
- Ensure that you have the necessary permissions to access SecurityEvent logs and run queries.
- Review the definitions of EventID to ensure the script aligns with your organisation's security event logging standards.

## License
This KQL script is provided under the MIT License. See the root LICENSE file for details.
