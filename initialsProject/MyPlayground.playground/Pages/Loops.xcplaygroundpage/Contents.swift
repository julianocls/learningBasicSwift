import Foundation

// MARK: For Loops

// ranges
let count = 1...10
for number in count {
    print("Number is \(number)")
}

// arrays
let albums = ["Red", "1989", "Reputation"]
for album in albums {
    print("\(album) is on Apple Music")
}

// Se você não usar a constante que os forloops fornecem, você deve usar um sublinhado para que o Swift não crie valores desnecessários:
print("Players gonna ")
for _ in 1...5 {
    print("play")
}


// MARK: While Loops
var number = 1
while number <= 20 {
    print(number)
    number += 1
}

print("Ready or not, here I come!")


// MARK: Repeat Loops
var numbers = 1
repeat {
    print(numbers)
    numbers += 1
} while numbers <= 20

print("Ready or not, here I come!")

// Como a condição vem no final do repeatloop, o código dentro do loop sempre será executado pelo menos uma vez, enquanto whileos loops verificam sua condição antes da primeira execução.
// Por exemplo, esta print()função nunca será executada, pois falseé sempre falsa:
while false {
    print("This is false")
}

// No caso acima, o Xcode até nos avisará que a print()linha nunca será executada.
// Por outro lado, esta print()função será executada uma vez, pois repeatsó falha a condição após a execução do loop:

repeat {
    print("This is false")
} while false


// MARK: Exiting Loops
var countDown = 10
while countDown >= 0 {
    print(countDown)

    if countDown == 4 {
        print("I'm bored. Let's go now!")
        break
    }

    countDown -= 1
}


// MARK: Exiting multiple loops

// Se você colocar um loop dentro de um loop, ele é chamado de loop aninhado , e não é incomum querer sair do loop interno e do loop externo ao mesmo tempo.
// Se quisermos sair no meio do caminho, precisamos fazer duas coisas. Primeiro, damos um rótulo ao loop externo, assim:
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")
    }
}

outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")

        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}


// MARK: Skipping Items

// Como você viu, a palavra- breakchave sai de um loop. Mas se você quiser apenas pular o item atual e continuar para o próximo, você deve usar continue.
// Para tentar isso, podemos escrever um loop de 1 a 10 e usar o operador restante do Swift para pular quaisquer números ímpares:

for i in 1...10 {
    if i % 2 == 1 {
        continue
    }

    print(i)
}


// MARK: Infinite Loops

var counter = 0
while true {
    print(counter)
    counter += 1

    if counter == 273 {
        break
    }
}


outer: for i in 1...10 {
    for i in 1...10 {
        let product = i * j
        print("Product is \(product)")
        break outer
    }
}





























