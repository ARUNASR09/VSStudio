import sqlite3
import pandas as pd
conn=sqlite3.connect('staff.db')
table_name = 'Instructor'
attr_list = ['Id','FName','LName','City','CCode']
file_path = './python1/INSTRUCTOR.csv'
df = pd.read_csv(file_path,names=attr_list)
df.to_sql(table_name,conn,if_exists='replace',index=False)

query_stmt = f"SELECT * from {table_name}"
query_output=pd.read_sql(query_stmt,conn)
print(query_stmt)
print(query_output)

query_stmt = f"SELECT FName from {table_name}"
query_output=pd.read_sql(query_stmt,conn)
print(query_stmt)
print(query_output)

query_stmt = f"SELECT Count(1) from {table_name}"
query_output=pd.read_sql(query_stmt,conn)
print(query_stmt)
print(query_output)

data_dict = {'ID' : [100],
            'FNAME' : ['John'],
            'LNAME' : ['Doe'],
            'CITY' : ['Paris'],
            'CCODE' : ['FR']}
df_append = pd.DataFrame(data_dict)
df_append.to_sql(table_name,conn,if_exists='append',index=False)
print('Data is appended to the table')

query_stmt = f"SELECT Count(1) from {table_name}"
query_output=pd.read_sql(query_stmt,conn)
print(query_stmt)
print(query_output)

query_stmt = f"SELECT Count(1) from {table_name}"
query_output=pd.read_sql(query_stmt,conn)
print(query_stmt)
print(query_output)

table_name = 'Departments'
file_path = './python1/Departments.csv'
attr_list = ['DeptId','DepName','Manager_Id','Loc_ID']
df = pd.read_csv(file_path,names=attr_list)
df.to_sql(table_name,conn,if_exists='replace',index=False)
print('Table is loaded')

query_stmt = f"SELECT * from {table_name}"
query_output=pd.read_sql(query_stmt,conn)
print(query_stmt)
print(query_output)

conn.close()