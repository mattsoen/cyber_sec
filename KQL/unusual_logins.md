# Documentation for Unusual Logins KQL Script

## Overview
This KQL script identifies users with an unusual number of successful logins from different locations, based on a defined threshold. It helps in detecting potentially suspicious login behavior.

## Script Details

### Query Breakdown
1. **Define a Threshold**:
   - `let Threshold = 3;`: Sets a threshold value for the number of distinct locations a user can log in from before being considered unusual.

2. **Identify User Locations**:
   - **Source**: `SigninLogs`
   - **Filter**: 
     - `ResultType == "0"`: Focuses on successful login events.
   - **Summarisation**:
     - `summarize DistinctLocations = dcount(Location) by UserPrincipalName`: Counts the distinct locations from which each user has logged in.

3. **Count Unusual Locations**:
   - **Source**: `SigninLogs`
   - **Filter**: 
     - `ResultType == "0"`: Again focuses on successful logins.
   - **Summarisation**:
     - `summarize UnusualLocations = dcount(Location) by UserPrincipalName`: Counts the distinct locations for each user.
   - **Join Operation**:
     - `join kind=inner (UserLocations) on UserPrincipalName`: Joins the unusual locations with the previously calculated user locations.

4. **Filter Based on Threshold**:
   - `where UnusualLocations > Threshold`: Filters users who have logged in from more locations than the defined threshold.

### Output
- **Columns**:
  - **`UserPrincipalName`**: The email address or username of the user.
  - **`UnusualLocations`**: The count of distinct locations from which the user has successfully logged in.

## How to Execute
1. **Prerequisites**: Ensure you have access a service that allows running KQL queries against Azure AD SigninLogs.
2. **Execution**:
   - Copy and paste the following KQL script into your query editor:
     ```kql
     let Threshold = 3;  // Define a threshold for unusual logins
     let UserLocations = SigninLogs
         | where ResultType == "0"  // Successful login
         | summarize DistinctLocations = dcount(Location) by UserPrincipalName;
     SigninLogs
     | where ResultType == "0"  // Successful login
     | summarize UnusualLocations = dcount(Location) by UserPrincipalName
     | join kind=inner (UserLocations) on UserPrincipalName
     | where UnusualLocations > Threshold
     ```
3. **Run the Query**: Execute the query to retrieve the results.

## Customisation
- **Threshold**: Adjust the `Threshold` variable to set a different number of locations for identifying unusual logins.
- **Location Definition**: Modify the `Location` field if your log data uses a different naming convention for geographic locations.

## Notes
- Ensure that you have the necessary permissions to access SigninLogs and run queries.
- Review the `ResultType` definitions to confirm they align with your organisation's login event criteria.

## License
This KQL script is provided under the MIT License. See the root LICENSE file for details.
