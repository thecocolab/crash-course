import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import mne

# Numpy Examples

# Creating a Numpy array
arr = np.array([1, 2, 3, 4, 5])
print("Numpy Array:", arr)

# Performing operations on the array
mean_value = np.mean(arr)
print("Mean:", mean_value)

# Pandas Examples

# Creating a Pandas DataFrame
data = {'Name': ['John', 'Alice', 'Bob'], 'Age': [25, 30, 22]}
df = pd.DataFrame(data)
print("Pandas DataFrame:")
print(df)

# Accessing columns in Pandas DataFrame
ages = df['Age']
print("Ages Column:")
print(ages)

# Matplotlib Examples

# Creating a simple plot
x = np.linspace(0, 10, 100)
y = np.sin(x)

plt.plot(x, y)
plt.xlabel('X-axis')
plt.ylabel('Y-axis')
plt.title('Sinusoidal Plot')
plt.show()

# MNE-Python Examples
import os # This is a Python module for interacting with the operating system

# define path to data
path = os.path.join(mne.datasets.sample.data_path(), 'MEG', 'sample', 'sample_audvis_raw.fif')

# Loading example MEG data
sample_data_path = mne.datasets.sample.data_path()
raw = mne.io.read_raw_fif(path, preload=True)

# Plotting the raw data
raw.plot()

# Selecting and plotting a specific range of time
start, stop = raw.time_as_index([10, 20])  # Selecting data between 10s and 20s
data, times = raw[:, start:stop]
plt.plot(times, data.T)
plt.xlabel('Time (s)')
plt.ylabel('MEG data (T)')
plt.title('MEG Data between 10s and 20s')
plt.show()

