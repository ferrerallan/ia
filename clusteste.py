import numpy  as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sb



df = pd.read_csv("E:\sistemas\clusterizacao\iris.csv")
sb.pairplot(df)
plt.show()

X = np.array(df.drop('target',axis = 1))

from sklearn.cluster import KMeans

kmeans = KMeans(n_clusters=3, random_state=0)

kmeans.fit(X)

print(kmeans.labels_)

df['K-classes'] = kmeans.labels_

sb.pairplot(df,hue='target')