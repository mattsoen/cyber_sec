# Documentation for Failed Logins KQL Script

## Overview
This KQL script queries the Azure Active Directory SigninLogs to identify failed login attempts. It summarises the count of failed login attempts for each user over a one-hour time interval.

## Script Details

### Query Breakdown
- **Source**: `SigninLogs`
- **Filter**: 
  - `ResultType == "50074"`: Filters the logs to include only failed login attempts.
  
### Operations
- **Summarisation**:
  - `summarize FailedLogins = count() by UserPrincipalName, bin(TimeGenerated, 1h)`: Counts the number of failed login attempts grouped by the user's principal name and time, with a time bin of one hour.
  
- **Sorting**:
  - `order by FailedLogins desc`: Orders the results in descending order based on the count of failed logins.

### Output
- **Columns**:
  - **`UserPrincipalName`**: The email address or username of the user attempting to log in.
  - **`FailedLogins`**: The total number of failed login attempts for each user within the specified time bins.
  - **`TimeGenerated`**: The time interval during which the failed logins occurred, rounded to the nearest hour.

## How to Execute
1. **Prerequisites**: Ensure you have access to a service that allows running KQL queries against Azure AD SigninLogs.
2. **Execution**:
   - Copy and paste the following KQL script into your query editor:
     ```kql
     SigninLogs
     | where ResultType == "50074"  // Failed login attempt
     | summarize FailedLogins = count() by UserPrincipalName, bin(TimeGenerated, 1h)
     | order by FailedLogins desc
     ```
3. **Run the Query**: Execute the query to retrieve the results.

## Customisation
- **Time Range**: You can modify the time range in which you run the query to focus on specific periods of interest.
- **Result Filtering**: Adjust the filtering criteria (e.g., different `ResultType` values) to explore other types of login results.

## Notes
- Ensure that you have the necessary permissions to access SigninLogs and run queries.
- The `ResultType` for failed login attempts may vary; ensure to verify against current documentation for Azure AD logs.

## License
This KQL script is provided under the MIT License. See the root LICENSE file for details.
