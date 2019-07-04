from base import avaliacoes

from math import sqrt

def euclidiana(procedimento1,procedimento2):
    si = {}
    for item in avaliacoes[procedimento1]:
        if item in avaliacoes[procedimento2]:si[item]=1

    if len(si)==0: return 0

    soma = sum([pow(avaliacoes[procedimento1][item] - avaliacoes[procedimento2][item],2)
                for item in avaliacoes[procedimento1] if item in avaliacoes[procedimento2]])

    return 1/(1+sqrt(soma))

def getSimilares(procedimento):
    similaridade=[(euclidiana(procedimento,outro), outro)
                    for outro in avaliacoes if outro != procedimento]
    similaridade.sort()
    similaridade.reverse()
    return similaridade


for procedimento in avaliacoes:
    similaresProced = getSimilares(procedimento)
    for similar in similaresProced:
        if similar[0] > 0.3 and similar[0] <= 1 :
            print(procedimento+"@"+similar[1]+": "+str(similar[0]))