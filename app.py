""" x = 1
y = 1
unit_price = 3
w = 1 """

# x, y, w, unit_price = 1, 1, 1, 3

x = y = w = 2
unit_price = 3
print(x, y, w, unit_price)

try:
    a = 1/0
except ZeroDivisionError:
    print('you are trying to divide the number by zero')


try:
    num = int('abc')
except ValueError:
    print('Trying to convert the wrong value of typecast')

try:
    with open("C://b.txt", 'r', encoding='utf-8') as a:
        pass
except FileNotFoundError:
    print('file not found')

try:
    mylist = [1,3,4]
    print(mylist[4])
except IndexError:
    print('index not found')

try:
    my_dict = {"name": "Alice", "age": 30}
    value = my_dict["city"]  # No KeyError, using .get() method
except KeyError:
    print('key not found')

print('value : ',2//1,1/2,2/1,1//2)

# using Try- except 
try:
    # Attempting to divide 10 by 0
    result = 10 / 1
except ZeroDivisionError:
    # Handling the ZeroDivisionError and printing an error message
    print("Error: Cannot divide by zero")
# This line will be executed regardless of whether an exception occurred
print("outside of try and except block")



