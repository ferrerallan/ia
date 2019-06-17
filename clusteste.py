import numpy  as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sb

df = pd.read_csv("internacaoexcede.csv")
sb.pairplot(df, hue='excedeu')
plt.show()
'''
X = np.array(df.drop('situacao',axis = 1))

from sklearn.cluster import KMeans

kmeans = KMeans(n_clusters=3, random_state=0)

kmeans.fit(X)

def to_string(coluna):
    retorno=""
    if (coluna==1):
        retorno="A"
    else:
        retorno="B"
    return retorno

df['Klasses'] = kmeans.labels_

df2 = df.drop(columns="situacao")
df2['target'] = df2['Klasses'].apply(to_string)
df2 = df2.drop(columns="Klasses")


#sb.pairplot(df2,hue='target')
#plt.show()
'''