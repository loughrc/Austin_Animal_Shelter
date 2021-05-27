## Predicting Austin Animal Shelter Outcomes

### Introduction:
This is a short and simple data exploration project involving a basic data cleaning exercise and model building to predict the outcome for animals that resided in Austin Animal Shelter, the largest no-kill animal shelter in the USA.

### The Data:
The data originated on Kaggle at https://www.kaggle.com/aaronschlegel/austin-animal-center-shelter-outcomes-and?select=aac_shelter_outcomes.csv. It gives us the features of animals that went through the shelter through the years 2013-2018. The years 2014-2017 contain a full year's worth of data, whereas for 2013 amd 2018 we only have data for a small fraction of each of those years. The features of the dataset include the outcome of each animal, the animal's age, date of birth, what date they were released from the shelter, what animal type, breed and colour they are, as well as the animal's name where applicable. This task involves cleaning down this data and keeping the features that will best predict the outcome of each animal, as well as organising the data in a way that it can be explored in MySQL and visualised using Tableau.

### Project Overview:
The data was first loaded into pandas as a dataframe where a short but rigorous data cleaning exercise was carried out in order to remove duplicate rows and columns, null values, and columns that would not be useful for prediction making. New features were also created both for the purpose of testing whether they would impact on prediction accuracy, and also with data visualisation in mind at a later stage of the project using Tableau. 

Random Forest and XGBoost classifiers were trained to predict the outcome of an animal based on the features we did not remove. Two different versions of each of these classifiers were trained: the first contained a large subset of features which include two newly engineered features: the month the animal was in the shelter and the year the animal was in the shelter. The second version of the models were trained with these two features excluded. There was very little reduction in the classification accuracy of each algorithm, and as we were training with less features this reduces both the training time and running time of the algorithm. A peak classification accuracy of 72% was achieved.

### Motivation:
The motivation for this project was to show how different technologies (MySQL, Tableau, Python) can be used for different purposes in a single project. While the entire project could have been done using different Python packages, it is interesting to look at the project from different perspectives, which leads you to use different data manipulation techniques to extract useful information.

### What problem does this project solve?
The idea of making a model to predict the outcome for each animal is so that we can identify, based on some very simple features of that animal, what outcome the animal will have. The more common outcomes include Adoption, Return to Owner, Transfer (to another shelter), Died (due to natural causes), and Euthanasia, and the model predicts the outcome for each animal. For example, animals with specific characteristics may pose a risk of spreading rabies, and a model should be able to predict that the outcome for these types of animals is that they need to be euthanised. These kinds of predictions can help an animal shelter to identify what kind of care needs to be given to each animal based on the predicted outcome for that animal.

### Technologies Used:
Python (pandas, numpy, scikit-learn), MySQL, Tableau Public.

### Summary:
A data exploration project involving a basic data cleaning exercise and model building to predict the outcome for animals that resided in this shelter
- Carried out a simple data exploration using MySQL
- Created some visualisations of the data on Tableau Public: https://public.tableau.com/profile/conor.loughran#!/vizhome/Austin_Animal_Shelter/Dashboard1
- Cleaned the data using the Python package pandas with prediction making in mind
- Compared the performance of Random Forest and XGBoost classifiers at predicting the outcome for an animal based on features such as animal type, age etc. 
