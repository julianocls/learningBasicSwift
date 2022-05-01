import UIKit
import Darwin

// Arrays
let arrays = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
arrays.first
arrays.last
arrays.count


// MARK: Set
let sets = Set(["aardvark", "astronaut", "azalea", "azalea"])
sets.first
sets.count

let colors = Set(["red", "green", "blue"])
let colors2 = Set(["red", "green", "blue", "red", "blue"])


// MARK: Tuplas
var name = (first: "Maria", last: "Silva", number: 123, date: Date.now)
name.1
name.first


name.number
name.number = 999 // change number

name.date

var name2 = (first: "Silva", last: "Maria", number: 123, date: Date.now)

var nomes = (nome1: name, nome2: name2)

///

//Se você precisar de uma coleção específica e fixa de valores relacionados em que cada item tenha uma posição ou nome preciso, use uma tupla:
let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")

//Se você precisar de uma coleção de valores que devem ser exclusivos ou precisar verificar se um item específico está lá de forma extremamente rápida, use um conjunto:
let set = Set(["aardvark", "astronaut", "azalea"])

//Se você precisar de uma coleção de valores que possam conter duplicatas, ou a ordem de seus itens for importante, você deve usar uma matriz:
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]

// MARK: dicionarios
let foods = [
    "pizza": 71.78,
    "sanduiche": 16.73
]

foods.first
foods.count
foods["sanduiche"]

foods["suco"]
foods["suco", default: 0]


// MARK: Criando coleções vazias

// Se você deseja criar uma coleção vazia , basta escrever seu tipo seguido de abrir e fechar parênteses. Por exemplo, podemos criar um dicionário vazio com strings para chaves e valores como este:
var teams = [String: String]()
teams["Paul"] = "Red"

// Da mesma forma, você pode criar um array vazio para armazenar inteiros como este:
var results = [Int]()
results.append(0)
results.append(1)

var results2 = Array<Int>()
results2.append(2)
results2.append(3)

// A exceção é criar um conjunto vazio, o que é feito de forma diferente:
var words = Set<String>()
var numbers = Set<Int>()

words.insert("batatas")
words.insert("empanados de frango com queijo")
words

numbers.insert(111)
numbers.insert(2222)
numbers


// MARK: Enumeration – geralmente chamadas apenas de enumerações – são uma maneira de definir grupos de valores relacionados de uma maneira que os torna mais fáceis de usar.
enum TipoPessoa {
    case fisica
    case juridica
    case extrangeira
}

TipoPessoa.fisica

enum Estados {
    case MG (descricao: String)
    case SP (descricao: String)
}
Estados.MG(descricao: "Minas Gerais")
Estados.SP(descricao: "São Paulo")

enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
}
let earth = Planet(rawValue: 2)

Planet.mercury.rawValue
Planet.venus.rawValue
Planet.earth.rawValue

enum Planet2: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}

Planet2.mercury.rawValue
Planet2.venus.rawValue
Planet2.earth.rawValue

enum Estado: String {
    case MG = "Minas Gerais"
    case RJ = "Rio de Janeiro"
    case SP = "São Paulo"
}

Estado.MG
Estado.MG.rawValue
Estado.MG.hashValue


