import requests
import pandas as pd
from datetime import datetime
import os
import hashlib

API_KEY = 'your_api_key'
VT_API_URL = 'https://www.virustotal.com/api/v3/files/'
FILE_NAME = 'vt_file_analysis_results_' + datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
DIRECTORY = r'C:\some\path'  # Change to your desired source folder path

def sha256_hash_file(file_path):
    #Generate SHA-256 hash for a given file.
    sha256_hash = hashlib.sha256()
    with open(file_path, "rb") as f:
        # Read and update hash string value in blocks of 4K
        for byte_block in iter(lambda: f.read(4096), b""):
            sha256_hash.update(byte_block)
    return sha256_hash.hexdigest()

def get_files(folder_path):
    # Generate a list of file paths from the specified folder
    file_paths = []
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            file_path = os.path.join(root, file)
            file_paths.append(file_path)
    return file_paths

def analyse_file(file):
    hash = sha256_hash_file(file)
    response = requests.get(VT_API_URL + hash, headers={'x-apikey': API_KEY})
    return response.json()

df_list = []

if __name__ == "__main__": 
    files = get_files(DIRECTORY)
    for file in files:
        result = analyse_file(file)
        last_analysis_date = result['data']['attributes']['last_analysis_date']
        last_analysis_stats = result['data']['attributes']['last_analysis_stats']

        # Create a DataFrame for the current file's analysis
        current_df = pd.DataFrame([{
            'File': file,
            'Last Analysis Date': datetime.fromtimestamp(last_analysis_date).strftime('%Y-%m-%d %H:%M:%S'),
            'Current Datetime': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
            **last_analysis_stats
        }])

        # Append the current DataFrame to the list
        df_list.append(current_df)

    # Concatenate all DataFrames in the list into a single DataFrame
    final_df = pd.concat(df_list, ignore_index=True)

    # Save the final DataFrame to a CSV file
    final_df.to_csv(FILE_NAME + '.csv', index=False)

    print(final_df)
