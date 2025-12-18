# Machine Learning and scikit-learn Module

Welcome to the Module 5: Machine Learning and scikit-learn! This repository provides resources to help you understand the theory and practice of machine learning, with a focus on scikit-learn and some applications to electrophysiology brain data.

## Table of Contents
0. [Google interactive ML Course](https://developers.google.com/machine-learning/crash-course/prereqs-and-prework)
   - ML models (Linear Regression, Logistic Regression, Classification)
   - Data (Numerical and categorical), Generalization and Overfitting
   - Advanced ML models (Neural Networks, Embeddings, LLMs) (Optional)
   - Real-worl ML (Optional)

1. [Introduction to Machine Learning (Tübingen)](https://www.youtube.com/playlist?list=PL05umP7R6ij35ShKLDqccJSDntugY4FQT)
   - Linear regression
   - Logistic regression
   - Regularization
   - Boosting
   - Neural networks
   - PCA
   - Clustering
   - ...

2. Practice with scikit-learn (selected from [MAIN2022 Conference - Educational](https://main-educational.github.io/intro.html))
   - Supervised learning using scikit-learn:
     - [Tutorial](https://www.youtube.com/watch?v=bnIH84oYRnE)
     - [Code](https://github.com/neurodatascience/main-edu-courses-ml/tree/main/intro_to_supervised_learning)
     - **Objectives:**
        - Define machine-learning nomenclature
        - Describe basics of the learning process
        - Explain model design choices and performance trade-offs
        - Introduce model selection and validation frameworks
        - Explain model performance metrics
     - **Questions you will be able to answer:**
        - What is under/over-fitting in model training?
        - What is (nested) cross-validation in model selection?
        - What are type-1 and type-2 errors in model evaluation?

   - Model selection and validation:
     - [Tutorial](https://www.youtube.com/watch?v=X7RBbD__MJw)
     - [Code](https://github.com/neurodatascience/main-edu-courses-ml/tree/main/ml_model_selection_and_validation)
     - **Objectives:**
        - Understand how to evaluate the performance of machine learning models
        - Learn about hyperparameters and model selection
        - Learn about pitfalls when validating machine learning models and how to avoid them using scikit-learn

   - Machine learning on EEG/MEG:
     - [Tutorial](https://www.youtube.com/watch?v=ePrxz7wRp1g)
     - [Code](https://github.com/agramfort/22_main_ml_meeg_tuto)
     - **Objectives:**
        - Understand the structure of EEG/MEG signals
        - Preprocess and visualize MEG/EEG data
        - Learn ML techniques to decode evoked and induced MEG/EEG activity
        - Train machine learning models on MEG data using MNE-python and PyTorch
    
3. To apply what you have learned. We prepared some notebook to train. 
   - [01-Classification-Titanic_Dataset.ipynb](#)
      This notebook guides you through a comprehensive machine learning approach to address the Titanic disaster. It covers data cleaning, feature engineering, and model development, emphasizing classification. The goal is to predict passenger survival (binary: 1 for survived, 0 for not survived) using the well-known Titanic dataset, which is available for download on Kaggle. **Please download the data and place it in the `data/` folder (you may need to create it).**
   - [02-Regression-Prediction_taxi_fare_NYC.ipynb](#)
      This tutorial introduces a regression task: predicting taxi fare amounts in New York City. Covering outlier handling, data cleaning, feature engineering, and Random Forest Regressor training, it guides you through regression analysis. The goal is to predict continuous fare amounts using a dataset split into training and test sets. **Please download the data and place it in the `data/` folder.**
   - [AP4-Machine_Learning_and_Brain_Wave_Classification.ipynb](#)
      Explore signal feature selection and model choice considerations, emphasizing diverse machine learning algorithms' effectiveness using the scikit-learn library in neuroscience applications.

4. Further Intermediate Machine Learning Courses
   - [Caltech CS156: Learning from Data](https://www.youtube.com/playlist?list=PLD63A284B7615313A)
     - Lecture topics include the learning problem, linear models, error and noise, bias-variance tradeoff, neural networks, and more.

   - [Stanford CS229: Machine Learning](https://www.youtube.com/playlist?list=PLoROMvodv4rMiGQp3WXShtMGgzqpfVfbU)
     - Lecture topics include linear regression, gradient descent, logistic regression, SVMs, decision trees, neural networks, and more.
   
   - [Machine Learning with Josh Starmer](https://www.youtube.com/playlist?list=PLblh5JKOoLUICTaGLRoHQDuF_7q2GfuJF)
     - Short video that explain Machine Learning concepts and models. 
    