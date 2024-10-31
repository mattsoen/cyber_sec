# Documentation for VirusTotal IP Analysis Script

## Overview
This Python script analyses foreign IP addresses obtained from the system's network connections using the `netstat` command. It queries the VirusTotal API to gather security analysis results for each IP address and saves the results to a CSV file.

## Script Details

### Get Foreign IPs
- **Purpose**: To extract foreign IP addresses from active network connections.
- **Actions**:
  - Runs the `netstat -an` command to list active connections.
  - Filters the output to collect valid IPv4 addresses.

### Analyse IP
- **Purpose**: To query the VirusTotal API for security analysis of a given IP address.
- **Actions**:
  - Sends a GET request to the VirusTotal API and returns the analysis result.

### Main Execution Flow
- **Purpose**: To orchestrate the collection of foreign IPs, analyse each IP, and save the results.
- **Actions**:
  - Collects foreign IPs and iterates through them to retrieve their analysis from VirusTotal.
  - Compiles the results into a Pandas DataFrame and saves them to a CSV file.

## How to Run
1. **Prerequisites**:
   - Ensure you have Python installed on your system.
   - Install the required libraries.
   - Obtain a VirusTotal API key and replace `'your_vt_api_key'` with your actual API key in the script.

2. **Execution**:
   - Save the script as `vt_ip_analysis.py`.
   - Run the script in your terminal.

## Customisation
- **API Key**: Replace the placeholder for `API_KEY` with your actual VirusTotal API key.
- **Output File Name**: Modify the `FILE_NAME` variable if you want a different naming convention for the output CSV file.

## Notes
- Ensure you have the necessary permissions to run `netstat` and access the internet for API calls.
- Be aware of the API rate limits imposed by VirusTotal to avoid exceeding your quota.

## License
This script is provided under the MIT License. See the root LICENSE file for details.
