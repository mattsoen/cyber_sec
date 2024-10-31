import requests
import pandas as pd
from datetime import datetime
import base64

API_KEY = 'your_vt_api_key'
VT_API_URL = 'https://www.virustotal.com/api/v3/urls/'
FILE_NAME = 'vt_url_analysis_results_' + datetime.now().strftime('%Y-%m-%d_%H-%M-%S')

def get_urls():
    # Insert your custom logic to retrieve url data from your desired source
    retrieved_urls = ['https://example.com','https://google.com']
    return retrieved_urls

def analyse_url(url):
    # Encode the string to bytes
    byte_string = url.encode('utf-8')
    # Base64 encode the byte string
    encoded_bytes = base64.b64encode(byte_string)
    # Convert the encoded bytes back to a string and remove padding
    url_encoded = encoded_bytes.decode('utf-8').rstrip('=')
    response = requests.get(VT_API_URL + url_encoded, headers={'x-apikey': API_KEY})
    return response.json()

df_list = []

if __name__ == "__main__": 
    urls = get_urls()
    for url in urls:
        result = analyse_url(url)
        last_analysis_date = result['data']['attributes']['last_analysis_date']
        last_analysis_stats = result['data']['attributes']['last_analysis_stats']

        # Create a DataFrame for the current URL's analysis
        current_df = pd.DataFrame([{
            'URL': url,
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
