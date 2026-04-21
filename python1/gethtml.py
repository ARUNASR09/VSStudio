import requests
import os 
from PIL import Image
from IPython.display import IFrame

url='https://www.ibm.com/'
r=requests.get(url)

if r.status_code == 200:
    print('Success')
    print(r.request.headers)
    print("body :",r.request.body)
    headers = r.headers
    print(r.headers)
    print(headers['Date'])
    print(headers['Content-Type'])
    print(r.encoding)
    #print(r.text)

url='https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-PY0101EN-SkillsNetwork/IDSNlogo.png'
r=requests.get(url)

if r.status_code == 200:
    print('Success')
    print(r.headers)
    #print(r.text)

    path=os.path.join(os.getcwd(),'image.png')
    with open(path,'wb') as f:
        f.write(r.content)
    
    Image.open(path)


url = 'https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-PY0101EN-SkillsNetwork/labs/Module%205/data/Example1.txt'
path=os.path.join(os.getcwd(),'example.txt')
r = requests.get(url)
print(r.headers)
if r.status_code == 200:
    with open(path,'wb') as f:
        f.write(r.content)
print(r.content)

url_get='http://httpbin.org/get'
payload={"name":"Joseph","ID":"123"}
r= requests.get(url_get,params=payload)
print(r.url)
print("request body:", r.request.body)
if r.status_code == 200:
     print(r.headers)
     print(r.headers['Content-Type'])
     print(r.text)
     print(r.json())
     print(r.json()['args'])


url_post='http://httpbin.org/post'
r_post=requests.post(url_post,data=payload)
#print("POST request URL:",response.url )
#print("GET request URL:",r.url)
print("POST request URL:", r_post.url)  # Use r_post instead of response
print("POST request body:",r_post.request.body)
print("GET request body:",r.request.body)

print(r_post.json()['form'])