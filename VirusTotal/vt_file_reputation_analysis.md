# Documentation for VirusTotal File Analysis Script

## Overview
This Python script analyses files in a specified directory by querying the VirusTotal API for security reports. It generates the SHA-256 hash of each file, retrieves analysis results, and saves them to a CSV file.

## Script Details

### SHA-256 Hashing
- **Purpose**: To generate a SHA-256 hash for a given file.
- **Actions**:
  - Reads the file in binary mode and computes the hash in blocks to handle large files efficiently.

### Get Files
- **Purpose**: To retrieve a list of file paths from the specified directory.
- **Actions**:
  - Uses `os.walk` to traverse the directory and collect all file paths.

### Analyse File
- **Purpose**: To query the VirusTotal API for the security analysis of a given file.
- **Actions**:
  - Sends a GET request to the VirusTotal API using the SHA-256 hash of the file.

### Main Execution Flow
- **Purpose**: To orchestrate the collection of files, analyse each file, and save the results.
- **Actions**:
  - Collects file paths, retrieves analysis from VirusTotal, compiles the results into a Pandas DataFrame, and saves the results to a CSV file.

## How to Run
1. **Prerequisites**:
   - Ensure you have Python installed on your system.
   - Install the required libraries.
   - Obtain a VirusTotal API key and replace `'your_api_key'` with your actual API key in the script.

2. **Execution**:
   - Change the `DIRECTORY` variable to the path of the folder you wish to analyse.
   - Save the script as `vt_file_analysis.py`.
   - Run the script in your terminal.

## Customisation
- **API Key**: Replace the placeholder for `API_KEY` with your actual VirusTotal API key.
- **Source Folder**: Modify the `DIRECTORY` variable to point to the desired folder containing files for analysis.
- **Output File Name**: Adjust the `FILE_NAME` variable if you want a different naming convention for the output CSV file.

## Notes
- Ensure you have the necessary permissions to read the files in the specified directory.
- Be aware of the API rate limits imposed by VirusTotal to avoid exceeding your quota.

## License
This script is provided under the MIT License. See the root LICENSE file for details.
