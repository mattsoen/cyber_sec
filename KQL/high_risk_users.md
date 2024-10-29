# Documentation for High Risk Users KQL Script

## Overview
This KQL script identifies high-risk users based on non-successful login attempts and their associated identity risk events. It filters users who have more than a specified number of failed login attempts and cross-references this data with identity risk events marked as high risk.

## Script Details

### Query Breakdown
1. **Identify High-Risk Users**:
   - **Source**: `SigninLogs`
   - **Filter**: 
     - `ResultType != "0"`: Excludes successful logins to focus on non-successful attempts.
   - **Summarisation**:
     - `summarize Attempts = count() by UserPrincipalName`: Counts the total non-successful login attempts for each user.
   - **Threshold**:
     - `where Attempts > 5`: Filters users with more than 5 failed login attempts. Adjust the threshold as necessary.

2. **Join with Identity Risk Events**:
   - **Source**: `IdentityRiskEvents`
   - **Filter**:
     - `where RiskLevel == "High"`: Focuses on events where the risk level is marked as high.
   - **Join Operation**:
     - `join kind=inner (HighRiskUsers) on UserPrincipalName`: Joins the high-risk users with their corresponding high-risk identity events.

3. **Projection**:
   - `project TimeGenerated, UserPrincipalName, RiskLevel, Attempts`: Selects specific columns for the final output.

### Output
- **Columns**:
  - **`TimeGenerated`**: The timestamp of the identity risk event.
  - **`UserPrincipalName`**: The email address or username of the user.
  - **`RiskLevel`**: The risk level associated with the identity event.
  - **`Attempts`**: The total number of non-successful login attempts for the user.

## How to Execute
1. **Prerequisites**: Ensure you have access to a service that allows running KQL queries against Azure AD SigninLogs and IdentityRiskEvents.
2. **Execution**:
   - Copy and paste the following KQL script into your query editor:
     ```kql
     let HighRiskUsers = SigninLogs
         | where ResultType != "0"  // Non-successful logins
         | summarize Attempts = count() by UserPrincipalName
         | where Attempts > 5;  // Adjust threshold as necessary
     IdentityRiskEvents
     | where RiskLevel == "High"
     | join kind=inner (HighRiskUsers) on UserPrincipalName
     | project TimeGenerated, UserPrincipalName, RiskLevel, Attempts
     ```
3. **Run the Query**: Execute the query to retrieve the results.

## Customisation
- **Threshold**: Adjust the number of failed login attempts in the `where Attempts > 5` clause to tailor the sensitivity of high-risk user identification.
- **Risk Level**: Modify the `RiskLevel` filter to include other levels if necessary (e.g., "Medium").

## Notes
- Ensure that you have the necessary permissions to access SigninLogs and IdentityRiskEvents and run queries.
- Review the definitions of `ResultType` and `RiskLevel` to ensure the script aligns with your organisation’s policies and data standards.

## License
This KQL script is provided under the MIT License. See the root LICENSE file for details.
