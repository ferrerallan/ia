import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sb

df = pd.read_csv("sgti15.csv")

#df = df.drop(columns='TEMPO')

df = df.fillna(0)

#print(df)


#plt.interactive(False)
#sb.pairplot(df, hue='TIPO')
#plt.show()


df = df.drop(columns='TIPO')

X = np.array(df)

from sklearn.cluster import KMeans

kmeans = KMeans(n_clusters=3, random_state=0)

kmeans.fit(X)

df['Klasses'] = kmeans.labels_
print(df)
#df['target'] = df['Klasses'].apply(to_string)

#print(dffim)

sb.pairplot(df)

#sb.pairplot(dfDirty)
plt.show()
