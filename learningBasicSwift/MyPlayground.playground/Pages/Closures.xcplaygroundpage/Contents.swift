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
    print("I'm getting ready to go - Trailling closure sintax. - travel2")
    action()
    print("I arrived! - Trailling closure sintax - travel2")
}

travel2() {
    print("I'm driving in my car - Trailling closure sintax - travel2")
}

travel2 {
    print("I'm driving in my car - Trailling closure sintax - travel2")
}


// MARK: Using closures as parameters when they accept parameters

func travel3(action: (String) -> Void) {
    print("I'm getting ready to go - travel3.")
    action("London - travel3")
    print("I arrived! - travel3")
}

travel3 { (place: String) in
    print("I'm going to \(place) in my car - travel3")
}


// MARK: Using closures as parameters when they return values

func travel4(action: (String) -> String) {
    print("I'm getting ready to go. - travel4")
    let description = action("London - travel4")
    print(description)
    print("I arrived! - travel4")
}

travel4 { (place: String) -> String in
    return "I'm going to \(place) in my car - travel4"
}

func increaseBankBalance(start: Double, interestCalculator: () -> Double) {
    print("Your current balance is \(start).")
    let interestRate = interestCalculator()
    let withInterest = start * interestRate
    print("You now have \(withInterest).")
}

increaseBankBalance(start: 200.0) {
    return 1.01
}


// MARK: Shorthand parameter names

// Acabamos de fazer uma travel()função. Ele aceita um parâmetro, que é um closure que aceita um parâmetro e retorna uma string. Esse encerramento é então executado entre duas chamadas para print().
// Aqui está isso no código:
func travel5(action: (String) -> String) {
    print("I'm getting ready to go. - travel5")
    let description = action("London - travel5")
    print(description)
    print("I arrived! - travel5")
}


// Podemos chamar travel()usando algo assim:
travel5 { (place: String) -> String in
    return "I'm going to \(place) in my car - travel5"
}


//No entanto, Swift sabe que o parâmetro para esse encerramento deve ser uma string, então podemos removê-lo:
travel5 { place -> String in
    return "I'm going to \(place) in my car - travel5"
}


// Ele também sabe que o encerramento deve retornar uma string, para que possamos removê-lo:
travel5 { place in
    return "I'm going to \(place) in my car - travel5"
}


// Como o closure tem apenas uma linha de código que deve ser aquela que retorna o valor, o Swift nos permite remover a returnpalavra-chave também:
travel5 { place in
    "I'm going to \(place) in my car - travel5"
}


// O Swift tem uma sintaxe abreviada que permite que você seja ainda mais curto. Em vez de escrever place in, podemos deixar o Swift fornecer nomes automáticos para os parâmetros do encerramento. Estes são nomeados com um cifrão e, em seguida, um número contando a partir de 0.
travel5 {
    "I'm going to \($0) in my car - travel5"
}


// MARK: Closures with multiple parameters

func travel6(action: (String, Int) -> String) {
    print("I'm getting ready to go. - travel6")
    let description = action("London - travel6", 60)
    print(description)
    print("I arrived! - travel6")
}

travel6 {
    "I'm going to \($0) at \($1) miles per hour. - travel6"
}


// MARK: Returning closures from functions

// Da mesma forma que você pode passar um closure para uma função, você também pode obter closures de uma função.
// A sintaxe para isso é um pouco confusa no início, porque usa ->duas vezes: uma vez para especificar o valor de retorno da sua função e uma segunda vez para especificar o valor de retorno da sua closure.
// Para testar isso, vamos escrever uma travel()função que não aceita parâmetros, mas retorna um encerramento. O fechamento que é retornado deve ser chamado com uma string e não retornará nada.
// Veja como isso fica no Swift:

func travel7() -> (String) -> Void {
    return {
        print("I'm going to \($0) - travel7")
    }
}

// Agora podemos chamar travel()para recuperar esse encerramento e chamá-lo como uma função:
let result = travel7()
result("London - travel7")

// É tecnicamente permitido – embora realmente não seja recomendado! – para chamar o valor de retorno travel()diretamente:
travel7()("London - travel7")


// MARK: Capturing Values

// Se você usar quaisquer valores externos dentro de seu fechamento, o Swift os captura – os armazena ao lado do fechamento, para que possam ser modificados mesmo que não existam mais.
// Neste momento temos uma travel()função que retorna um closure, e o closure retornado aceita uma string como seu único parâmetro e não retorna nada:

func travel8() -> (String) -> Void {
    return {
        print("I'm going to \($0) - travel8")
    }
}

// Podemos chamar travel()para recuperar o encerramento e, em seguida, chamar esse encerramento livremente:

let result8 = travel8()
result8("London - travel8")

// A captura de fechamento acontece se criamos valores travel()que são usados ​​dentro do fechamento. Por exemplo, podemos querer rastrear com que frequência o encerramento retornado é chamado:

func travel9() -> (String) -> Void {
    var counter = 1

    return {
        print("counter: \(counter). I'm going to \($0) - travel9")
        counter += 1
    }
}

// Mesmo que essa countervariável tenha sido criada dentro travel()de , ela é capturada pelo encerramento para que ainda permaneça ativa para esse encerramento.
// Então, se ligarmos result("London")várias vezes, o contador subirá e subirá:
let result9 = travel9()
result9("London - travel9")
result9("London - travel9")
result9("London - travel9")








