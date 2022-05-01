
import Foundation


// MARK: Variadic functions
print("Haters", "gonna", "hate")

func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

square(numbers: 1, 2, 3, 4, 5)


// MARK: Writing throwing functions
enum PasswordError: Error {
    case obvious
    case itsOk
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

// executando função trows
do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

do {
    try checkPassword("password123")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}


// MARK: Inout Parameters
// Todos os parâmetros passados ​​para uma função Swift são constantes , então você não pode alterá-los. Se desejar, você pode passar um ou mais parâmetros como inout, o que significa que eles podem ser alterados dentro de sua função, e essas alterações refletem no valor original fora da função.

// Por exemplo, se você quiser dobrar um número no lugar – ou seja, alterar o valor diretamente em vez de retornar um novo – você pode escrever uma função como esta:

func doubleInPlace(number: inout Int) {
    number *= 2
}


// Para usar isso, primeiro você precisa fazer um inteiro variável – você não pode usar inteiros constantes com inout, porque eles podem ser alterados. Você também precisa passar o parâmetro para doubleInPlaceusar um e comercial, &, antes de seu nome, que é um reconhecimento explícito de que você está ciente de que está sendo usado como inout.

// No código, você escreveria isso para chamar a função:

var myNum = 10
doubleInPlace(number: &myNum)
print(myNum)
