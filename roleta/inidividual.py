import random
import time



cont = 0
array10 = []
for j in range(1, 200):
    numero=-1
    cont = 1
    while numero != 33:
        #time.sleep(0.05)
        numero = random.randint(0, 36)
        
        print(str(cont))
        cont+=1
        
   
    array10.append(cont)
    
    pilha = []

#print(str(minutos) + " rodadas")


def Average(lst):
    return sum(lst) / len(lst)


average = Average(array10)

# Printing average of the list
print("Average of the list =", round(average, 2))
