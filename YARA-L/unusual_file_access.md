# Documentation for Unusual File Access Detection Rule

## Overview
This rule detects unusual access to sensitive files during non-business hours. It aims to identify potentially malicious activities, such as unauthorised file exports, downloads, or transfers.

## Rule Details

### Metadata
- **Author**: MO
- **Description**: Detects unusual access to sensitive files outside of normal business hours.
- **Severity**: HIGH

### Events
The rule triggers based on the following conditions:
1. **Event Type**:
   - The event must be a file access event:  
     `$file_access.metadata.event_type = "FILE_ACCESS"`

2. **File Path**:
   - The path of the accessed file is compared to the specified sensitive file path:  
     `$file_access.target.file.path = $file_path`

3. **Action**:
   - The action must be allowed:  
     `$file_access.security_result.action = "ALLOW"`

4. **Timestamp**:
   - The timestamp of the file access event is stored for analysis:  
     `$ts = $file_access.metadata.event_timestamp.seconds`

5. **Non-Business Hours Check**:
   - Access must occur during non-business hours (between 19:00 and 07:00):  
     `(timestamp.get_hour($ts, "UTC") >= 0 and timestamp.get_hour($ts, "UTC") < 7) or
     timestamp.get_hour($ts, "UTC") >= 19`

6. **Sensitive Directory Check**:
   - The accessed file must reside in a sensitive directory:  
     `$file_path matches "^/sensitive_directory/.*"`

### Match Conditions
The rule looks for specific keywords in the event log or related metadata:
- The message contains "export":
  `$file_access.metadata.message contains "export"`
- The message contains "download":
  `$file_access.metadata.message contains "download"`
- The message contains "transfer":
  `$file_access.metadata.message contains "transfer"`

### Outcome
The rule calculates the frequency of access events:
- **Access Frequency**: 
  - Counts the number of access events recorded:  
    `$access_frequency = count($file_access)`

### Condition
The rule is triggered if all specified conditions are met:
`$file_access and $access_frequency > 5 and $match`

## How to Use
1. **Deployment**: Integrate this rule into your security monitoring system capable of handling custom detection rules.
2. **Monitoring**: Review alerts generated by this rule to investigate unusual file access activities.
3. **Adjustment**: Modify parameters based on your organisation’s file access policies and operational hours.

## Customisation
- **Time Range**: Adjust the non-business hour conditions to match your organisation's specific operating hours.
- **Sensitive Directory**: Change the directory path in the `$file_path` variable to reflect your sensitive files' actual location.
- **Access Frequency**: Change the access frequency number in the Condition clause to reflect your risk appetite.

## Notes
- Test this rule in a controlled environment to fine-tune its sensitivity and reduce false positives.
- This rule should complement other security measures and policies regarding file access and data protection.

## License
This rule is provided under the MIT License. See the root LICENSE file for details.
