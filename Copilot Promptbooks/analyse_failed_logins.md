# Documentation for Analyse Failed Logins Promptbook Template

## Overview
This promptbook retrieves the details of the latest failed logins, providing insights into user authentication issues.

## Template Details

### Tags
- **`Logins`**
- **`Entra`**

### Inputs
- **`NUMBER`**: The number of latest failed logins to retrieve. *(Type: integer)*

### Plugins
- **`Microsoft Entra`**

## Prompts

1. **Failed Login Analysis**  
   Analyse the last `<NUMBER>` failed logins. Include details such as UPN, timestamps, IP addresses, and reasons for failures.

2. **Authentication Methods**  
   What are the authentication methods for the failed logins?

3. **Account Lockouts**  
   Were these accounts locked out?

4. **Previous Login Failures**  
   How many login failures have these accounts recorded previously?

5. **New Account Report**  
   If any of these accounts have been created in the last week, prepare a report on the account. Include details such as account creation details, access policies, and activity history.

## How to Run
1. **Prerequisites**: Ensure that you have appropriate access to run the promptbook and access to the required data sources.
2. **Inputs**: You can pass inputs directly at runtime.

## Customisation
- **PROMPTS**: Modify the wording of the prompts to suit your reporting format or analysis needs.

## License
This template is provided under the MIT License. See the root LICENSE file for details.
