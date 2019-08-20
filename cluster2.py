import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
import seaborn as sb

df = pd.read_csv('sgti15.csv')

df = pd.concat([df, pd.get_dummies(df['TIPO'])], axis=1)

df = df.drop(columns='TIPO')

for col in  df.columns:
    df[col] = df[col].astype(float)

X = df

kmeans = KMeans(n_clusters=3, random_state=0).fit(X)
X_clustered = kmeans.fit_predict(X)

X['clusterNumber'] = X_clustered

print(df.dtypes)

LABEL_COLOR_MAP = {0 : 'red', 1 : 'blue', 2: 'green'}
label_color = [LABEL_COLOR_MAP[l] for l in X_clustered]

feature1 = 2 # valor do índice da coluna
feature2 = 1
labels = ['TEMPO', 'ANO', 'BENNER','COMPUTADOR']
c1label = labels[feature1]
c2label = labels[feature2]

plt.figure(figsize = (12,12))
plt.scatter(X.iloc[:, feature1],X.iloc[:, feature2], c=label_color, alpha=0.3)
plt.xlabel(c1label, fontsize=18)
plt.ylabel(c2label, fontsize=18)

plt.show()