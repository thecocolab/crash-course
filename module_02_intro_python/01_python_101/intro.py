# Assigning values to variables
age = 26                    # an integer representing age
height = 5.9                # a float representing height in feet
name = "Panda"              # a string representing a name
is_student = True           # a boolean indicating whether a person is a student or not

# Creating a list and a tuple
fruits = ['apple', 'banana', 'orange']    # a list containing different fruits
coordinates = (3, 5)                       # a tuple representing coordinates (x, y)

# Creating a dictionary
person = {'name': 'Hamza', 'age': 26, 'is_student': True}    # a dictionary representing information about a person

# Accessing and modifying elements in a list and a dictionary
print(fruits[0])         # Output: apple
fruits.append('grape')   # Adding 'grape' to the list
person['age'] = 31       # Modifying the age in the dictionary

# Printing formatted strings using f-strings
print(f"My name is {person['name']} and I'm {person['age']} years old.")

# Iterating through a list and performing operations
for fruit in fruits:
    print(f"Hello, {fruit.capitalize()}!")

# Using a for loop with range and performing arithmetic operations
for i in range(5):
    result = i + 2
    print(f"Adding two: {i} + 2 = {result}")
