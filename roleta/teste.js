
const arrayGeral = []
let contador=0


function getRandomIntInclusive(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

  
function wait(ms){
    var start = new Date().getTime();
    var end = start;
    while(end < start + ms) {
        end = new Date().getTime();
    }
}

while (contador<36)
{
    contador++
    arrayGeral.push(contador)
}

let pilha = []
let arraydiferenca = []
let cont = 0
arrayMinutos = []

arrayTentativa=[]

cont=0
contGeral=0
while (contGeral<100)
{
    while (arraydiferenca.length != 4)
    {
        numero = getRandomIntInclusive(0, 36)
        pilha.push(numero)

        arraydiferenca = arrayGeral.filter(v => !pilha.includes(v))
        console.log(arraydiferenca)
        cont++  

        console.log(numero)
    }
    arrayTentativa.push(cont)
    contGeral++
    cont=0
    pilha=[]
    arraydiferenca=[]
}

const sum = arrayTentativa.reduce((a, b) => a + b, 0);
const avg = (sum / arrayTentativa.length) || 0;


console.log(arrayTentativa)
console.log("media"+avg)
