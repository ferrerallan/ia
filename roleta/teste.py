import random
import time

arrayGeral = []
for i in range(0, 37):
    arrayGeral.append(i)

#print(arrayGeral)

pilha = [-1]
arraydiferenca = []
cont = 0
arrayMinutos = []
arraymedio = []
segundos=2
for j in range(1, 1000):
    for j in range(1, 2):
        numero = random.randint(0, 36)
        pilha.append(numero)
    print("pilha")
    print(pilha)
    arraydiferenca = list(filter(lambda x: (x not in pilha), arrayGeral))
    print("array diferenca")
    print(arraydiferenca)
    time.sleep(segundos)
    top5 = random.sample(arraydiferenca, 5)
    time.sleep(segundos)
    print("top 5")
    print(top5)
    time.sleep(segundos)
    if (len(top5)>=5):
        cont = 0
        numero = -1
        while (numero not in top5):
            cont += 1
            numero = random.randint(0, 36)
            print("numero sorteado")
            print(numero)
            time.sleep(segundos)
            print("cont")
            print(cont)
            time.sleep(segundos)
            #print(numero)
        arraymedio.append(cont)
        print("arraymedio")
        print(arraymedio)
    
    pilha = []


def Average(lst):
    return sum(lst) / len(lst)

#print(arraymedio)
print("maximo")
print(max(arraymedio))
print("media")
print(Average(arraymedio))
print("minimo")
print(min(arraymedio))
print("arraymedio")
print(arraymedio)