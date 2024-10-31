# Documentation for VirusTotal URL Analysis Script

## Overview
This Python script analyses a list of URLs by querying the VirusTotal API for security reports. It retrieves URLs, encodes them in base64 format, and saves the analysis results to a CSV file.

## Script Details

### Get URLs
- **Purpose**: To retrieve a list of URLs for analysis.
- **Actions**:
  - Implements custom logic to collect URLs from a specified source. In the provided example, it uses a static list of URLs.

### Analyse URL
- **Purpose**: To query the VirusTotal API for security analysis of a given URL.
- **Actions**:
  - Encodes the URL in base64 format (without padding) and sends a GET request to the VirusTotal API to retrieve the analysis result.

### Main Execution Flow
- **Purpose**: To orchestrate the collection of URLs, analyse each URL, and save the results.
- **Actions**:
  - Collects URLs and iterates through them to retrieve their analysis from VirusTotal.
  - Compiles the results into a Pandas DataFrame and saves them to a CSV file.

## How to Run
1. **Prerequisites**:
   - Ensure you have Python installed on your system.
   - Install the required libraries.
   - Obtain a VirusTotal API key and replace `'your_vt_api_key'` with your actual API key in the script.

2. **Execution**:
   - Save the script as `vt_url_analysis.py`.
   - Run the script in your terminal.

## Customisation
- **API Key**: Replace the placeholder for `API_KEY` with your actual VirusTotal API key.
- **URL Retrieval**: Modify the `get_urls()` function to implement your own logic for retrieving URLs from your desired data source.
- **Output File Name**: Adjust the `FILE_NAME` variable if you want a different naming convention for the output CSV file.

## Notes
- Ensure you have internet access for API calls.
- Be aware of the API rate limits imposed by VirusTotal to avoid exceeding your quota.

## License
This script is provided under the MIT License. See the root LICENSE file for details.
