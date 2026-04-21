from randomuser import RandomUser
import pandas as pd
r = RandomUser()
list_users = r.generate_users(10)
print(list_users)

for user in list_users:
    print(user.get_full_name(), '|',user.get_email())

'''
get_cell()
get_city()
get_dob()
get_email()
get_first_name()
get_full_name()
get_gender()
get_id()
get_id_number()
get_id_type()
get_info()
get_last_name()
get_login_md5()
get_login_salt()
get_login_sha1()
get_login_sha256()
get_nat()
get_password()
get_phone()
get_picture()
get_postcode()
get_registered()
get_state()
get_street()
get_username()
get_zipcode()
'''