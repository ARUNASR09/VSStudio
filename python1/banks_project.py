import requests
from bs4 import BeautifulSoup
import pandas as pd
import numpy as np
from datetime import datetime
import lxml
import sqlite3
from tabulate import tabulate



def log_progress(message):
    timestamp_format = '%Y-%h-%d-%H:%M:%S'
    time1  = datetime.now()
    disp_time = time1.strftime(timestamp_format)
    with open('./code_log.txt','a') as f:
        f.write(disp_time + " : " + message + '\n')

def extract(url, table_attribs):
    html = requests.get(url).text
    data = BeautifulSoup(html,'html.parser')
     
    tables = data.find_all('tbody')
    rows = tables[0].find_all('tr')
    dict = {}
    df = pd.DataFrame(columns=table_attribs)
    for row in rows:
        col = row.find_all('td')
        
        if len(col) != 0:
            #print(col[1].find('a'))

            if col[1].find_all('a'):
                    country = col[1].find_all('a')
                    #dict = {"Name":country[1].contents[0].strip(),
                     #       "MC_USD_Billion":col[2].contents[0].strip('\n')}
                    dict = {"Name":col[1].find_all('a')[1]['title'],
                            "MC_USD_Billion":col[2].contents[0][:-1]}
                    df1 = pd.DataFrame(dict,index=[0])
                    df = pd.concat([df,df1],ignore_index=True)
    return df

def exchange_csv(csv):
    df = pd.read_csv(csv)
    #print(df)
    dict = df.set_index('Currency').to_dict()['Rate']
    return dict

def transform(df, csv_path):
    df1 = pd.read_csv(csv_path)
    dict = df1.set_index('Currency').to_dict()['Rate']
    #dict = exchange_csv(csv_path)
    gdp_rate = float(dict['GBP'])
    inr_rate = float(dict['INR'])
    eur_rate = float(dict['EUR'])
    df['MC_GBP_Billion'] = [np.round(float(x) * gdp_rate,2) for x in df['MC_USD_Billion']]
    df['MC_EUR_Billion'] = [np.round(float(x) * eur_rate,2) for x in df['MC_USD_Billion']]
    df['MC_INR_Billion'] = [np.round(float(x) * inr_rate,2) for x in df['MC_USD_Billion']]
    return df

def load_to_csv(df, output_path):
    df.to_csv(output_path)
    


def load_to_db(df, sql_connection, table_name):
    df.to_sql(table_name,sql_connection,if_exists='replace',index=False)


def run_query(query_statement, sql_connection):
    print(query_statement)
    output = pd.read_sql(query_statement,sql_connection)
    print(output)


url = "https://web.archive.org/web/20230908091635/https://en.wikipedia.org/wiki/List_of_largest_banks"
table_attribs = ["Name","MC_USD_Billion"]
db_name = 'Banks.db'
table_name = 'Largest_banks'
csv_path = './Largest_banks_data.csv'

log_progress('Preliminaries complete. Initiating ETL process')
df = extract(url,table_attribs)
print(tabulate(df, headers=table_attribs, tablefmt='psql'))

log_progress('Data extraction complete. Initiating Transformation process')
transform_data=transform(df,'./exchange_rate.csv')
print(tabulate(transform_data, headers='keys', tablefmt='psql'))
print(transform_data.head(10))
log_progress('Data transformation complete. Initiating Loading process')
load_to_csv(transform_data,csv_path)
log_progress('Data saved to CSV file')
log_progress('SQL Connection initiated')
conn = sqlite3.connect(db_name)
load_to_db(transform_data,conn,table_name)
log_progress('Data loaded to Database as a table, Executing queries')
query=f"SELECT * FROM {table_name}"
run_query(query,conn)
query=f"SELECT AVG(MC_GBP_Billion) FROM {table_name}"
run_query(query,conn)
query=f"SELECT Name FROM {table_name} limit 5"
run_query(query,conn)
log_progress('Process Complete')
conn.close()
log_progress('Server Connection closed')
