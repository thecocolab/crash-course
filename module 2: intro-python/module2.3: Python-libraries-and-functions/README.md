# Python Libraries and functions

In this module, you will learn how to use pip to manage Python libraries and work with four essential libraries: Numpy, Pandas, Matplotlib, and MNE-Python. Next we will move to introducting functions and their utilities.

## Libraries 

### Pip and Installing Libraries

#### What is Pip?

Pip is a package manager for Python, used to install and manage Python packages. It simplifies the process of installing, upgrading, and managing external libraries.

#### Installing Libraries with Pip

To install a library using pip, open your terminal or command prompt and run the following command (make sure your virtual env is active!!!):

```bash
pip install library_name
```

Replace `library_name` with the name of the library you want to install.

To incorporate a library into your Python script, you must first import it, typically at the beginning of your code. Various methods exist for importing libraries, yet each library usually has a standardized approach, ensuring code readability for other users. This agreed-upon convention can be discovered either online or within the library's official documentation. Consistent usage of these import conventions contributes to a more accessible and collaborative coding environment.


### Numpy

#### What is Numpy?

Numpy is a powerful numerical computing library for Python. It provides support for large, multi-dimensional arrays and matrices, along with mathematical functions to operate on these arrays.

#### Installing Numpy

```bash
pip install numpy
```

#### Using Numpy

```python
import numpy as np

# Create a Numpy array
arr = np.array([1, 2, 3, 4, 5])

# Perform operations on the array
mean_value = np.mean(arr)
print(f"Mean: {mean_value}")
```

### Pandas

#### What is Pandas?

Pandas is a data manipulation and analysis library for Python. It provides data structures like Series and DataFrame, making it easy to manipulate, analyze, and visualize data.

#### Installing Pandas

```bash
pip install pandas
```

#### Using Pandas

```python
import pandas as pd

# Create a DataFrame
data = {'Name': ['John', 'Alice', 'Bob'], 'Age': [25, 30, 22]}
df = pd.DataFrame(data)

# Display the DataFrame
print(df)
```

### Matplotlib

#### What is Matplotlib?

Matplotlib is a 2D plotting library for Python. It allows you to create a variety of plots and charts to visualize data.

#### Installing Matplotlib

```bash
pip install matplotlib
```

#### Using Matplotlib

```python
import matplotlib.pyplot as plt

# Create a simple plot
x = [1, 2, 3, 4, 5]
y = [10, 12, 5, 8, 15]

plt.plot(x, y)
plt.xlabel('X-axis')
plt.ylabel('Y-axis')
plt.title('Simple Plot')
plt.show()
```

### MNE-Python

#### What is MNE-Python?

MNE-Python is a library for analyzing magnetoencephalography (MEG) and electroencephalography (EEG) data. It provides tools for data preprocessing, visualization, and analysis of brain signals.

#### Installing MNE-Python

```bash
pip install mne
```

#### Using MNE-Python

```python
import mne

# Load example MEG data
sample_data_path = mne.datasets.sample.data_path()
raw = mne.io.read_raw_fif(sample_data_path + '/MEG/sample/sample_audvis_raw.fif', preload=True)

# Plot the raw data
raw.plot()
```

Execute the `libraries.py` script to run all the examples provided above. If you require additional guidance on using the libraries, consult their respective websites or documentation for more detailed instructions and insights.

---

## Functions in Python

### What are Functions?

Functions in Python are reusable blocks of code that perform a specific task. They help in organizing code, making it more modular and readable.

### Defining a Function

```python
def greet(name):
    print(f"Hello, {name}!")

# Call the function
greet("Hamza")
```

### Return Values

```python
def add_numbers(a, b):
    return a + b

result = add_numbers(3, 4)
print("Sum:", result)
```

### Lambda Functions

Lambda functions, also known as anonymous functions, are concise ways to create small, unnamed functions. They are defined using the `lambda` keyword.

```python
# Example of a lambda function that squares its input
square = lambda x: x**2

result = square(5)
print("Square:", result)
```

### When do I need to create a function?

Every block of code that you need more than once should be a function.

Execute the `fucntions.py` script to run all the examples of functions provided above.


