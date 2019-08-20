import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sb

#lendo e transformando csv em dataframe
df = pd.read_csv("movimento.csv")

#preenchendo valores nulos com zero
df = df.fillna(0)

#df = pd.concat([df, pd.get_dummies(df['TIPO'])], axis=1)
#df = df.drop(columns='variety')
X = np.array(df)
from sklearn.cluster import KMeans
kmeans = KMeans(n_clusters=3, random_state=0)
kmeans.fit(X)
df['cluster'] = kmeans.labels_

def getDescricao(cluster):
    if cluster == 0:
        return 'GRUPO1'
    if cluster == 1:
        return 'GRP2'
    if cluster == 2:
        return 'GRP3'



df['grupo'] = df.apply(lambda row: getDescricao(row.cluster), axis = 1)


df = df.drop(columns='cluster')
print(df)
#plotando infos

#print(df)

sb.pairplot(df,hue='grupo')
plt.show()

#df = pd.concat([df, pd.get_dummies(df['TIPO'])], axis=1)
#print(df)




#print(df)
#df['target'] = df['Klasses'].apply(to_string)

#print(dffim)

#sb.pairplot(df)

#sb.pairplot(dfDirty)
#plt.show()
