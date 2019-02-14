# Il y a des lignes de code à décommenter si tu veux tester en local avec le csv qu'on a

import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from imblearn.over_sampling import RandomOverSampler
from sklearn.preprocessing import Imputer

def stringify(dataFrame, list_word={}):
    """Permet de convertir les colonnes de string en int
    Renvoie le dictionnaire utilisé pour cette conversion et la bdd stringifiée"""
    
    def word2int(row):
        if row not in list_word[name_col]:
            list_word[name_col].append(row)
        return list_word[name_col].index(row)

    for name_col in dataFrame.columns:
        if isinstance(dataFrame[name_col].iloc[0], str):
            list_word[name_col] = []
            dataFrame[name_col] = dataFrame.loc[:, name_col].apply(word2int)
            
    return dataFrame, list_word

# On lit les données d'entrainement
data = pd.read_csv("dataset.csv")
target = pd.DataFrame(data=data.TARGET)
del data['TARGET']
#data_initial = pd.read_csv("dataset.csv")
#data = data_initial[:1000]
#target = pd.DataFrame(data=data.TARGET)
#del data['TARGET']

# On numérise toutes les données
data, list_word = stringify(data)

# On remplace les NaN par a valeur moyenne dans la colonne
imputer = Imputer(missing_values='NaN', strategy='mean')
data = pd.DataFrame(imputer.fit_transform(data), columns=data.columns)

# On fait un over-fitting pour qu'il n'y est pas de classe prépondérante par rapport à une autre
ros = RandomOverSampler()
data, target = ros.fit_resample(data, target)

# On entraine le modèle de RandomForest
model = RandomForestClassifier(n_estimators = 50, max_depth = 30)
model.fit(data, target)

# On lit les données à évaluer
data = pd.read_csv("data2evaluate.csv")
#data = data_initial[1001:1005]
#del data['TARGET']

# On numérise toutes les données
data, list_word = stringify(data, list_word=list_word)

# On remplace les NaN par a valeur moyenne dans la colonne
imputer = Imputer(missing_values='NaN', strategy='mean')
data = pd.DataFrame(imputer.fit_transform(data), columns=data.columns)

# On évalue et on affiche le résultat
print(model.predict(data))