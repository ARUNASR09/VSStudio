import pandas as pd
import json

import xml.etree.ElementTree as ET
import xml.etree.ElementTree as etree

from PIL import Image 

def warn(*args, **kwargs):
    pass
import warnings
warnings.warn = warn
warnings.filterwarnings('ignore')



filename = "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-PY0101EN-SkillsNetwork/labs/Module%205/data/file_example_XLSX_10.xlsx"

#The below function is download the files from the above link
""" async def download(url, filename):
    response = await pyfetch(url)
    if response.status == 200:
        with open(filename, "wb") as f:
            f.write(await response.bytes())

await download(filename, "file_example_XLSX_10.xlsx") """

#columns = ['Track_name','Artist_Name','Album_name','count','rating','len']
df = pd.read_csv("c:/Users/nanoi/OneDrive/Desktop/AI/POSTGRES/track_raw.csv",header=None)
df.columns = ['Track_name','Artist_Name','Album_name','count','rating','len']
print(df)

#columns = ['Track_name','Artist_Name','Album_name','count','rating','len']
df1 = pd.read_csv(r"C:\Users\nanoi\OneDrive\Desktop\AI\IBM_python\addresses.csv",header=None)
df1.columns =['First Name', 'Last Name', 'Location ', 'City','State','Area Code']
print(df1)


person = {
    'first_name' : 'Mark',
    'last_name' : 'abc',
    'age' : 27,
    'address': {
        "streetAddress": "21 2nd Street",
        "city": "New York",
        "state": "NY",
        "postalCode": "10021-3100"
    }
}

with open('person.json', 'w') as f:  # writing JSON object
    json.dump(person, f)

print(f.closed)

json_object = json.dumps(person, indent = 4) 
  
# Writing to sample.json 
with open("sample.json", "w") as outfile: 
    outfile.write(json_object) 

print(outfile.closed)

with open("C:/Users/nanoi/OneDrive/Desktop/VS-Python/sample.json",'r') as f:
    json_file = json.load(f)
    print(json_file)

list_tracks= []
with open("C:/Users/nanoi/OneDrive/Desktop/VS-Python/library.json",'r') as f:
    for line in f:
        list_tracks.append(json.loads(line))
    print(list_tracks)

df = pd.read_json("C:/Users/nanoi/OneDrive/Desktop/VS-Python/library.json", lines=True)
print(df)

# Not needed unless you're running locally
# import urllib.request
# urllib.request.urlretrieve("https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-PY0101EN-SkillsNetwork/labs/Module%205/data/file_example_XLSX_10.xlsx", "sample.xlsx")



df = pd.read_excel(r"C:\Users\nanoi\OneDrive\Desktop\AI\IBM_python\file_example_XLSX_10.xlsx")
print(df)


# create the file structure
employee = ET.Element('employee')
details = ET.SubElement(employee, 'details')
first = ET.SubElement(details, 'firstname')
second = ET.SubElement(details, 'lastname')
third = ET.SubElement(details, 'age')
first.text = 'Shiv'
second.text = 'Mishra'
third.text = '23'

# create a new XML file with the results
mydata1 = ET.ElementTree(employee)
# myfile = open("items2.xml", "wb")
# myfile.write(mydata)
with open("new_sample.xml", "wb") as files:
    mydata1.write(files)



# Parse the XML file
tree = etree.parse("Sample-employee-XML-file.xml")

# Get the root of the XML tree
root = tree.getroot()

# Define the columns for the DataFrame
columns = ["firstname", "lastname", "title", "division", "building", "room"]

# Initialize an empty DataFrame
datatframe = pd.DataFrame(columns=columns)

# Iterate through each node in the XML root
for node in root:
    # Extract text from each element
    firstname = node.find("firstname").text
    lastname = node.find("lastname").text
    title = node.find("title").text
    division = node.find("division").text
    building = node.find("building").text
    room = node.find("room").text
    
    # Create a DataFrame for the current row
    row_df = pd.DataFrame([[firstname, lastname, title, division, building, room]], columns=columns)
    
    # Concatenate with the existing DataFrame
    datatframe = pd.concat([datatframe, row_df], ignore_index=True)

print(datatframe)

df_xml=pd.read_xml("Sample-employee-XML-file.xml", xpath="/employees/details") 
print(df_xml)

##By default it will writes index for everyrow starting with 0 ... . If we need to omit index we need to provide index is false 
datatframe.to_csv("employee.csv",index=False)

""" 
Data Formate	Read	        Save
csv	            pd.read_csv()	df.to_csv()
json	        pd.read_json()	df.to_json()
excel	        pd.read_excel()	df.to_excel()
hdf	            pd.read_hdf()	df.to_hdf()
sql	            pd.read_sql()	df.to_sql()
...	...	... """

img = Image.open('./dog.jpg','r') 
  
# Output Images 
img.show()



df_csv_diabetes = pd.read_csv("diabetes.csv")
print(df_csv_diabetes)
print(df_csv_diabetes.shape)
print(df_csv_diabetes.info)
print(df_csv_diabetes.describe())

missing_data = df_csv_diabetes.isnull()
print(missing_data.head(5))

for column in missing_data.columns.values.tolist():
    print(column)
    print (missing_data[column].value_counts())
    print("")   

# the below will read the html page

URL="https://web.archive.org/web/20230902185326/https://en.wikipedia.org/wiki/List_of_countries_by_GDP_%28nominal%29"
tables = pd.read_html(
    URL,
    storage_options={
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0 Safari/537.36"
    }
)

df = tables[3]
print(df)