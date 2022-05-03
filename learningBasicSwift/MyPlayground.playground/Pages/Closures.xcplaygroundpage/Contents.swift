//: [Previous](@previous)

import Foundation

/*
 Swift nos permite usar funções como qualquer outro tipo, como strings e inteiros. Isso significa que você pode criar uma função e atribuí-la a uma variável, chamar essa função usando essa variável e até mesmo passar essa função para outras funções como parâmetros.

 As funções usadas dessa maneira são chamadas closures e, embora funcionem como funções, são escritas de maneira um pouco diferente.

 Vamos começar com um exemplo simples que imprime uma mensagem
 */


// MARK: Creating Basic Closures

let dirigir = {
    print("Eu estou digirindo o meu carro")
}

dirigir()


// MARK: Accepting parameters

let driving = { (place: String) in
    print("I'm going to \(place) in my car")
}

driving("London")



// MARK: Closure as parameters

let driving2 = {
    print("I'm driving in my car {1}")
}

func travel(acao: () -> Void) {
    print("I'm getting ready to go.{2}")
    acao()
    print("I arrived!{3}")
}

travel(acao: driving2)


// MARK: Trailing closure syntax

func travel2(action: () -> Void) {
    print("I'm getting ready to go - Trailling closure sintax.")
    action()
    print("I arrived! - Trailling closure sintax")
}

travel2() {
    print("I'm driving in my car - Trailling closure sintax 1")
}

travel2 {
    print("I'm driving in my car - Trailling closure sintax 2")
}












