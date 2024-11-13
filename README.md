# Cardiovascular Risk Prediction

## Project Overview:
This project focuses on predicting the risk of cardiovascular diseases using machine learning techniques. The goal is to build a model that can classify individuals based on their risk factors such as age, cholesterol levels, smoking habits, and blood pressure. Various **feature extraction** and **classification** techniques have been applied to achieve optimal performance in predicting cardiovascular risk.

### Key Highlights:
- **Feature Extraction**: Techniques like **Principal Component Analysis (PCA)** and **Recursive Feature Elimination (RFE)** were used to reduce the number of features while retaining the most significant ones.
- **Classification**: A variety of supervised learning algorithms were implemented, including **Gradient Boosting**, **Random Forest**, and **XGBoost**.
- **Performance Evaluation**: The performance of each model was evaluated using metrics like **accuracy**, **precision**, **recall**, **F1-score**, and **confusion matrices**.

## Steps:
1. **Data Preprocessing**:
   - Cleaned the data by handling missing values, encoding categorical features, and normalizing numerical values.
   
2. **Feature Extraction**:
   - **PCA**: Applied to reduce the dimensionality of the dataset while retaining as much variance as possible.
   - **RFE**: Used to identify and select the most important features for model training.
   
3. **Model Training**:
   - Implemented several classification algorithms, such as:
     - Logistic Regression
     - Random Forest
     - Support Vector Machine (SVM)
     - XGBoost
     - Gradient Boosting
   - The models were fine-tuned to improve performance.

4. **Performance Metrics**:
   - Evaluated each model's performance using:
     - **Accuracy**
     - **Precision**
     - **Recall**
     - **F1-Score**
     - **Confusion Matrix**

5. **Results**:
   - After applying feature extraction and data preprocessing techniques, the models were able to achieve near-perfect accuracy in predicting cardiovascular risk.

## How to Run:
1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/yourusername/your-repository.git
