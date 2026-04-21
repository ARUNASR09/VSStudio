import pandas as pd
url = 'https://en.wikipedia.org/wiki/List_of_largest_banks'
url = 'https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(nominal)'


#the below does not work as wikipedia is using bots to avoid automated
#tables = pd.read_html(url)
tables = pd.read_html(
    url,
    storage_options={
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0 Safari/537.36"
    }
)


df = tables[2]
print(df)