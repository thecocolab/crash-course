# Python-MNE

## Introduction

MNE-Python is a powerful tool for the analysis of magnetoencephalography (MEG) and electroencephalography (EEG) data. Here are some reasons why MNE is useful:

1. **Comprehensive Signal Processing**: MNE-Python provides a wide range of tools for preprocessing MEG and EEG data. This includes filtering, artifact removal, resampling, and more. It allows researchers to clean and prepare the data effectively for analysis.

2. **Data Visualization**: MNE-Python offers extensive visualization capabilities, enabling researchers to explore and understand their data. This includes interactive plotting of raw data, topographical maps, source estimation results, and various statistical visualizations.

3. **Source Estimation**: MNE-Python allows for source localization, which is the process of estimating the brain regions responsible for recorded signals. This is crucial for understanding the spatial distribution of neural activity.

4. **Time-Frequency Analysis**: MNE supports time-frequency analysis techniques, such as Morlet wavelet transformations and multitaper spectral analysis. These tools are essential for investigating changes in neural oscillations over time.

5. **Machine Learning Integration**: MNE-Python can be integrated with machine learning libraries, enabling researchers to apply advanced statistical and machine learning techniques to analyze MEG and EEG data. This is valuable for classification tasks, pattern recognition, and predictive modeling.

6. **Open Source and Community Support**: MNE-Python is an open-source project with active community support. This means that researchers and developers from around the world contribute to its development, ensuring continuous improvement, bug fixes, and the addition of new features.

7. **Compatibility with Other Libraries**: MNE-Python is designed to work seamlessly with other scientific Python libraries such as NumPy, SciPy, and Matplotlib. This makes it part of a robust ecosystem for scientific computing and data analysis in Python.

8. **Applications in Research and Clinical Settings**: MNE-Python is widely used in both research and clinical settings. It has applications in cognitive neuroscience, clinical neurology, brain-computer interfaces, and various other fields.

9. **Educational Resources**: MNE-Python provides extensive documentation, tutorials, and examples. This makes it accessible for researchers, students, and educators who want to learn and teach about MEG and EEG data analysis.

## Use Cases

MNE-Python is widely used in various applications, including:

1. **Cognitive Neuroscience**: Analyzing brain activity related to cognitive tasks.
2. **Clinical Research**: Investigating neurological disorders through MEG and EEG data.
3. **Brain-Computer Interfaces**: Developing interfaces for communication based on brain signals.
4. **Neurofeedback**: Providing real-time feedback to individuals about their brain activity.

## Installation

To begin, we need to install the necessary libraries. You can use the `requirements.txt` file to install these libraries. To do this, activate your environment and run the following command in your terminal or command prompt:

```bash
pip install -r requirements.txt
```

The `requirements.txt` file is a text file commonly used in Python projects to specify the list of dependencies (libraries and their versions) required to run the project. Each line in the file typically represents a library and its version.

#### Why Use requirements.txt?

1. **Reproducibility**: It allows you to recreate the exact environment needed for your project. By specifying library versions, you ensure that others or future versions of yourself can set up the same environment without compatibility issues.

2. **Dependency Management**: When working on a project with multiple contributors, using a `requirements.txt` file helps to manage and share a consistent set of dependencies. Everyone can install the same versions of libraries, reducing the chances of conflicts.

## Getting Started with MNE-Python

MNE-Python provides a rich set of functionalities for loading, processing, and visualizing MEG and EEG data. Here is a simple example to get you started:

```python
import mne

# Load example MEG data
sample_data_path = mne.datasets.sample.data_path()
raw = mne.io.read_raw_fif(sample_data_path + '/MEG/sample/sample_audvis_raw.fif', preload=True)

# Plot the raw data
raw.plot()
```

This code loads an example MEG dataset and plots the raw data. Run this script to ensure MNE-Python is properly installed and working.

The Python-MNE website provides a set of useful tutorials that can guide you through various steps of an M/EEG study. You can access these tutorials [here](https://mne.tools/stable/documentation/index.html).

Here is a curated list to help you get started:

1. [Overview of MNE-Python](https://mne.tools/stable/auto_tutorials/intro/10_overview.html#sphx-glr-auto-tutorials-intro-10-overview-py)
2. [Configuring MNE](https://mne.tools/stable/auto_tutorials/intro/50_configure_mne.html)
3. [Overview of Raw Data](https://mne.tools/stable/auto_tutorials/raw/10_raw_overview.html)
4. [Event Arrays in MNE](https://mne.tools/stable/auto_tutorials/raw/20_event_arrays.html)
5. [Overview of Preprocessing](https://mne.tools/stable/auto_tutorials/preprocessing/10_preprocessing_overview.html)
6. [Overview of Epochs](https://mne.tools/stable/auto_tutorials/epochs/10_epochs_overview.html)
7. [Overview of Evoked Responses](https://mne.tools/stable/auto_tutorials/evoked/10_evoked_overview.html)

Feel free to copy and paste code snippets from these tutorials and experiment with them in your own project folder. Additionally, we have prepared a list of notebooks with exercises that will guide you through the main steps of M/EEG manipulation, processing, and analysis. These notebooks include exercises where you need to fill in the empty slots.

# List of Practical Activities:

## PA1 - Manipulation of Electrophysiological Data in MNE-Python
Introduction to MNE-Python and its operational logic. Overview of basic objects and functions (e.g., opening/visualizing data).

## PA2 - Preprocessing (Cleaning) of MEG and EEG Data
Creation of a data preprocessing pipeline, including filtering, ICA, and automatic rejection threshold estimation.

## PA3 - Analysis of Oscillations and Evoked Potentials
Introduction to basic tools for data segmentation and calculation of evoked potentials and oscillations.

## Further Reading & Practice
For more advanced and detailed notebooks specifically focused on working with brain data (including more on MNE-Python), please see the **[PSY2007D-UdeM repository](https://github.com/thecocolab/PSY2007D-UdeM)**. Check out notebooks `0` through `8` in that repository.


