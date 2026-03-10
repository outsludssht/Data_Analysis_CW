# Analysis of MAO-B Inhibitors: From ChEMBL Data to Predictive Modeling

## Project Overview
This project focuses on the computational analysis of MAO-B (monoamine oxidase B) inhibitors, a critical therapeutic target for neurodegenerative diseases like Parkinson’s and clinical depression. The study transitions from raw data extraction to advanced statistical validation and machine learning.

## Software Stack
Python: Pandas, Scikit-learn, RDKit (for chemoinformatics), NumPy.

R: ggplot2, networkD3, stats.

Other: HTML/JS for interactive visualizations.

## Project Milestones
### 1. Descriptive Statistics & EDA
Calculation of baseline indices (Mean, Median) for 5,884 compounds.

Distribution assessment of pChEMBL values using histograms and violin plots.

### 2. Interactive Visualization
Implementation of an Interactive Sankey Diagram to map the hierarchical relationships between chemical compounds and their scientific sources.

### 3. Statistical Hypothesis Testing
Rigorous evaluation of activity differences across chemical groups using t-tests and ANOVA to ensure data-driven conclusions.

### 4. Multivariate Analysis (PCA & Clustering)
Dimensionality reduction using Principal Component Analysis (PCA).

K-Means clustering to segment the chemical space into distinct groups based on structural similarities.

### 5. Predictive Modeling
Development of a Random Forest classification model to predict the activity levels of potential drug candidates.
