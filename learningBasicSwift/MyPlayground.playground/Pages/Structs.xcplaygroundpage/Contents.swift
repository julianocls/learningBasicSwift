//: [Previous](@previous)

import Foundation

// MARK: Creating Structs

struct Sport {
    var name: String
}

var tennis = Sport(name: "Tennis")
print(tennis.name)

tennis.name = "Lawn tennis"

print(tennis.name)


// MARK: Computed properties

struct Sport2 {
    var name: String
    var isOlympicSport: Bool

    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

let chessBoxing = Sport2(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)


// MARK: Property observers

// Os observadores de propriedade permitem que você execute o código antes ou depois de qualquer alteração de propriedade. Para demonstrar isso, escreveremos uma Progress estrutura que rastreia uma tarefa e uma porcentagem de conclusão.
//O que queremos que aconteça é que o Swift imprima uma mensagem toda vez amountque mudar, e podemos usar um didSetobservador de propriedade para isso. Isso executará algum código toda vez que for amountalterado:
// Você também pode usar willSet para agir antes que uma propriedade seja alterada, mas isso raramente é usado.

struct Progress {
    var task: String
    var amount: Int {
        willSet {
            print("\(task) - Starting change value")
        }
        
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}

//Agora podemos criar uma instância dessa estrutura e ajustar seu progresso ao longo do tempo:

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100


// MARK: Methods

struct City {
    var population: Int

    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
print(london.collectTaxes() )


// MARK: Mutating Methods

// Se uma estrutura possui uma propriedade variável, mas a instância da estrutura foi criada como uma constante, essa propriedade não pode ser alterada – a estrutura é constante, portanto, todas as suas propriedades também são constantes, independentemente de como foram criadas.

// O problema é que quando você cria o struct o Swift não tem ideia se você vai usá-lo com constantes ou variáveis, então por padrão ele usa a abordagem segura: o Swift não vai deixar você escrever métodos que alteram propriedades a menos que você o solicite especificamente.

// Quando você deseja alterar uma propriedade dentro de um método, você precisa marcá-la usando a palavra- mutatingchave, assim:

struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

// Por alterar a propriedade, o Swift só permitirá que esse método seja chamado em Personinstâncias que são variáveis:

var person = Person(name: "Ed")
person.makeAnonymous()


// MARK: Properties and methods of string

// Usamos muitas strings até agora, e elas são structs – elas têm seus próprios métodos e propriedades que podemos usar para consultar e manipular a string.
// Primeiro, vamos criar uma string de teste:

let string = "Do or do not, there is no try."

// Você pode ler o número de caracteres em uma string usando sua countpropriedade:

print(string.count)

// Eles têm um hasPrefix()método que retorna true se a string começar com letras específicas:

print(string.hasPrefix("Do"))

// Você pode colocar uma string em maiúscula chamando seu uppercased()método:

print(string.uppercased())

// E você pode até fazer com que o Swift classifique as letras da string em um array:

print(string.sorted())

// Strings têm muito mais propriedades e métodos - tente digitar string.para exibir as opções de conclusão de código do Xcode.


// MARK: Properties and methods of arrays

// Arrays também são structs, o que significa que eles também têm seus próprios métodos e propriedades que podemos usar para consultar e manipular o array.
// Aqui está um array simples para começarmos:

var toys = ["Woody"]

// Você pode ler o número de itens em uma matriz usando sua countpropriedade:

print(toys.count)

// Se você quiser adicionar um novo item, use o append()método como este:

toys.append("Buzz")

// Você pode localizar qualquer item dentro de um array usando seu firstIndex()método, assim:

toys.firstIndex(of: "Buzz")

// Isso retornará 1 porque os arrays contam a partir de 0.
// Assim como com strings, você pode fazer com que o Swift classifique os itens do array em ordem alfabética:

print(toys.sorted())

// Finalmente, se você quiser remover um item, use o remove()método assim:

toys.remove(at: 0)

// Os arrays têm muito mais propriedades e métodos - tente digitar toys.para exibir as opções de conclusão de código do Xcode.

