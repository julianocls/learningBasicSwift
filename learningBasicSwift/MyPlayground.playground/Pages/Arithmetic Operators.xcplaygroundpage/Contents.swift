//: [Previous](@previous)

import Foundation

let firstScore = 12
let secondScore = 4

// resto
let remainder = 13 % secondScore

// MARK: Sobrecarga de operadores: numeros
let meaningOfLife = 42
let doubleMeaning = 42 + 42

// MARK: Sobrecarga de operadores: caracteres
let fakers = "Fakers gonna "
let action = fakers + "fake"

// MARK: Sobrecarga de operadores: juntando arrays
let firstHalf = ["Juliano", "Cesar"]
let secondHalf = ["Luiz", "Santos"]
let beatles = firstHalf + secondHalf

// MARK: operadores de atribuição composta

var score = 100
score -= 5

var name = "Juliano"
name += " Santos"

// MARK: operadores de comparação
let firstScore2 = 6
let secondScore2 = 4

firstScore2 == secondScore2
firstScore2 != secondScore2

// MARK: Cada um deles também funciona com strings, porque as strings têm uma ordem alfabética natural:
"abc" <= "def"
"def" <= "abc"

// MARK: operador ternario
let firstCard = 11
let secondCard = 10
firstCard == secondCard ? "Cards are the same" : "Cards are different"


// MARK: swich case
let weather = "sunny"
switch weather {
case "rain":
    ("Bring an umbrella")
case "snow":
    ("Wrap up warm")
case "sunny":
    ("Wear sunscreen")
default:
    ("Enjoy your day!")
}

switch weather {
case "rain":
    ("Bring an umbrella")
    fallthrough
case "snow":
    ("Wrap up warm")
    fallthrough
case "sunny":
    ("Wear sunscreen")
    fallthrough
default:
    ("Enjoy your day!")
}

switch weather {
case "rain":
    ("Bring an umbrella")
    break
case "snow":
    ("Wrap up warm")
    break
case "sunny":
    ("Wear sunscreen")
    break
default:
    ("Enjoy your day!")
}

// MARK: operador de intervalor
/*
  O Swift nos dá duas maneiras de fazer ranges: os operadores ..<e . ...O operador de intervalo semi-aberto, ..<, cria intervalos até, mas excluindo o valor final, e o operador de intervalo fechado, ..., cria intervalos até e incluindo o valor final.

 Por exemplo, o intervalo 1..<5contém os números 1, 2, 3 e 4, enquanto o intervalo 1...5contém os números 1, 2, 3, 4 e 5.
 */

let pontuacao = 85

switch pontuacao {
case 0..<50:
    ("You failed badly.")
case 50..<85:
    ("You did OK.")
default:
    ("You did great!")
}

switch pontuacao {
case 0...50:
    ("You failed badly.")
case 50...85:
    ("You did OK.")
default:
    ("You did great!")
}

