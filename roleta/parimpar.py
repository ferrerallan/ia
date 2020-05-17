import random
import time

arrayGeral = []
for i in range(0, 37):
    arrayGeral.append(i)


repetiu = 0
tipoAtual="nada"
tipoAnterior="nadanada"
arrayRepeticoes=[]
for j in range(1, 10):
    numero = random.randint(0, 36)
    
    if (numero==0):
        tipoAtual="Z"
    else:
        if (numero%2) == 0:
            tipoAtual="P"
        else:
            tipoAtual="I"
    
    if (numero==0):
        arrayRepeticoes.append(-1)
    else:
        arrayRepeticoes.append(repetiu)

    if (tipoAnterior==tipoAtual):
        repetiu+=1
    else:
        repetiu=0

    print(tipoAtual)
    tipoAnterior=tipoAtual

print(arrayRepeticoes)

totalZero = len(list(filter(lambda x: x == -1, arrayRepeticoes)))
totalSem = len(list(filter(lambda x: x == 0, arrayRepeticoes)))
total1 = len(list(filter(lambda x: x == 1, arrayRepeticoes)))
total2 = len(list(filter(lambda x: x == 2, arrayRepeticoes)))
total3 = len(list(filter(lambda x: x == 3, arrayRepeticoes)))
total4 = len(list(filter(lambda x: x == 4, arrayRepeticoes)))
total5 = len(list(filter(lambda x: x == 5, arrayRepeticoes)))
total6 = len(list(filter(lambda x: x == 6, arrayRepeticoes)))
total7 = len(list(filter(lambda x: x == 7, arrayRepeticoes)))

totalGeral = len(arrayRepeticoes)
print("Total geral:" + str(totalGeral))
print("Total zero:" + str(totalZero))
print("Total sem:" + str(totalSem))
print("Total 1:" + str(total1))
print("Total 2:" + str(total2))
print("Total 3:" + str(total3))
print("Total 4:" + str(total4))
print("Total 5:" + str(total5))
print("Total 6:" + str(total6))
print("Total 7:" + str(total7))