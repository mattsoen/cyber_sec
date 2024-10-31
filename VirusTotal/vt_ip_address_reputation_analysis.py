import subprocess
import requests
import json
import pandas as pd
from datetime import datetime
import re

API_KEY = 'your_vt_api_key'
VT_API_URL = 'https://www.virustotal.com/api/v3/ip_addresses/'
FILE_NAME = 'netstat_vt_analysis_results_' + datetime.now().strftime('%Y-%m-%d_%H-%M-%S')

def get_foreign_ips():
    result = subprocess.run(['netstat', '-an'], capture_output=True, text=True)
    lines = result.stdout.splitlines()
    foreign_ips = set()

    # Use a regex to validate the IP address format
    ip_pattern = re.compile(r'^\d{1,3}(\.\d{1,3}){3}$')

    for line in lines:
        parts = line.split()
        if len(parts) > 2 and parts[2] != '0.0.0.0' and parts[2] != '*:*':
            # Get the IP address only
            foreign_ip = parts[2].split(':')[0]  
            # Check if it's a valid IPv4 address
            if ip_pattern.match(foreign_ip):
                foreign_ips.add(foreign_ip)

    return foreign_ips

def analyse_ip(ip):
    response = requests.get(VT_API_URL + ip, headers={'x-apikey': API_KEY})
    return response.json()

df_list = []

if __name__ == "__main__": 
    foreign_ips = get_foreign_ips()
    for ip in foreign_ips:
        result = analyse_ip(ip)
        ip_address = result['data']['id']
        last_analysis_date = result['data']['attributes']['last_analysis_date']
        last_analysis_stats = result['data']['attributes']['last_analysis_stats']

        # Create a DataFrame for the current IP's analysis
        current_df = pd.DataFrame([{
            'IP Address': ip_address,
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
