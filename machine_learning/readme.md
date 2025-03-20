# Network Intrusion Detection System: Anomaly and Attack Classification Using Machine Learning

## Business Context
With the growth of computer networks, security vulnerabilities are increasingly challenging to address, making **Intrusion Detection Systems (IDS)** crucial for detecting network anomalies and attacks. This project aims to develop a network intrusion detection system using machine learning.

## Objectives
- **Binomial Classification:** Identify if a network activity is **"Normal"** or an **"Attack"**.
- **Multinomial Classification:** Detect the specific type of attack (e.g., **Back, Smurf, RootKit, etc.**).

## Available Data
- The dataset consists of **10 files**, each representing different types of attacks and normal network activity.
- Features include **time, content, and host-based traffic data**, covering aspects such as:
  - Duration, protocol type, source/destination bytes.
  - Login status, error rates, and other relevant network metrics.
- Data types include **nominal, binary, and numeric values**.

## Key Tasks
### 1. Data Preparation
- Append all files and add an **"attack"** column based on the attack type.
- Handle **class imbalance** through resampling techniques.
- Create separate labels for **binomial and multinomial** classification.

### 2. Model Development
- Train **machine learning models** for both classification tasks using the prepared dataset.
- Implement strategies to address **data imbalance** during training.

## Expected Output
- **Intrusion detection models** with robust performance.
- **Accurate classification** of network activity into **normal or specific attack categories**.
- **Insights into key features** contributing to network anomalies.

This project aims to enhance **network security** by leveraging **machine learning** to detect and classify network intrusions effectively.

