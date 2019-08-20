import random
import pandas as pd
import seaborn as sb
import matplotlib.pyplot as plt

col_names =  ['numero', 'categoria', 'coluna']
df  = pd.DataFrame(columns = col_names)

for n in range(1,10000):
    df = df.append({'numero': random.randint(0,36)}, ignore_index=True)

def getCat(n):
    if n in [33,16,24,5,10,23,8,30,11,36,13,27]:
        return 1
    elif n in [1,20,14,31,9,6,34,17]:
        return 2
    elif n in [25,2,21,4,19,15,32,0,26,3,35,12,28,7,29,18,22]:
        return 3

def getCol(n):
    if n==0:
        return 0
    elif n in range(1,13):
        return 1
    elif n in range(13,25):
        return 2
    elif n in range(25,37):
        return 3

def to_str(n):
    return 'A'+str(n)

df['categoria'] = df.apply( lambda n: getCat(n.numero), axis=1)
df['coluna'] = df.apply( lambda n: getCol(n.numero), axis=1)
#df['tipo'] = df.apply(lambda c: to_str(c.categoria), axis=1)

#df = df.drop(columns='categoria')
print(df.mean())

#sb.lineplot(data=df, palette="tab10", linewidth=2.5)
#plt.show()