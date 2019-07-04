# come pastel, gosta de tofu, sabe sambar
japones1 = [1, 1, 0]
japones2 = [1, 1, 0]
japones3 = [1, 1, 0]
outro1 = [1, 1, 1]
outro2 = [0, 1, 1]
outro3 = [0, 1, 1]

dados = [japones1, japones2, japones3, outro1, outro2, outro3]
marcacoes = [1, 1, 1, -1, -1, -1]

from sklearn.naive_bayes import MultinomialNB

modelo = MultinomialNB()
modelo.fit(dados, marcacoes)

misterioso1 = [1, 1, 1]
misterioso2 = [1, 0, 0]
misterioso3 = [1, 0, 1]
testes = [misterioso1, misterioso2, misterioso3]
marcacoes_teste = [-1, 1, 1]

resultado = modelo.predict(testes)
print(resultado)


#testando acuracia
diferencas = resultado - marcacoes_teste

acertos = [d for d in diferencas if d==0]
total_de_acertos = len(acertos)
total_de_elementos = len(testes)

taxa_de_acerto = 100.0 * total_de_acertos / total_de_elementos
print(taxa_de_acerto)