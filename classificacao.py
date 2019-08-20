import pandas as pd

# come pastel, gosta de tofu, sabe sambar, come peixe
# preparando dados(isso normalmente viria de um csv)
japones1 = [1, 1, 0, 1]
japones2 = [1, 0, 0, 1]
japones3 = [0, 1, 0, 1]
outro1 = [1, 0, 1, 0]
outro2 = [0, 0, 1, 1]
outro3 = [1, 0, 0, 1]
# aprendizado supervisionado
dados = [japones1, japones2, japones3, outro1, outro2, outro3]
marcacoes = [1, 1, 1, -1, -1, -1]
# importando a biblioteca
from sklearn.naive_bayes import MultinomialNB
# treinando o modelo
modelo = MultinomialNB()
modelo.fit( dados, marcacoes)
# dados desconhecidos
misterioso1 = [1, 1, 1,0]
dataset_testes = [misterioso1]
# verdade que sabemos
marcacoes_teste = [-1, -1, -1,1]
# predicão
resultado = modelo.predict(dataset_testes)
print(resultado)