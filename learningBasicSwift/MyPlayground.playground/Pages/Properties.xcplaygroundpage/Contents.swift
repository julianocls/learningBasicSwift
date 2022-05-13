//: [Previous](@previous)

import Foundation

// Estruturas e classes (coletivamente: "tipos") podem ter suas próprias variáveis ​​e constantes, e elas são chamadas de propriedades. Eles permitem que você anexe valores aos seus tipos para representá-los exclusivamente, mas como os tipos também podem ter métodos, você pode fazer com que eles se comportem de acordo com seus próprios dados.

// Vejamos agora um exemplo:

struct Person1 {
    var clothes: String
    var shoes: String

    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}

let taylor1 = Person1(clothes: "T-shirts", shoes: "sneakers")
let other1 = Person1(clothes: "short skirts", shoes: "high heels")
taylor1.describe()
other1.describe()

// Como você pode ver, quando você usa uma propriedade dentro de um método, ela automaticamente usa o valor que pertence ao mesmo objeto.

// Observadores de propriedade
// O Swift permite adicionar código a ser executado quando uma propriedade está prestes a ser alterada ou foi alterada. Essa é frequentemente uma boa maneira de atualizar a interface do usuário quando um valor é alterado, por exemplo.
// Existem dois tipos de observador de propriedade: willSet e didSet, e eles são chamados antes ou depois de uma propriedade ser alterada. Em willSet o Swift fornece seu código com um valor especial chamado newValue que contém qual será o novo valor da propriedade, e em didSet é dado o oldValue para representar o valor anterior.

// Vamos anexar dois observadores de propriedade à clothespropriedade de um Personstruct:

struct Person2 {
    var clothes: String {
        willSet {
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }

        didSet {
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
}

func updateUI(msg: String) {
    print(msg)
}

var taylor2 = Person2(clothes: "T-shirts")
taylor2.clothes = "short skirts"

// Isso imprimirá as mensagens "Estou mudando de camisetas para saias curtas" e "Acabei de mudar de camisetas para saias curtas".
// Propriedades computadas
// É possível fazer propriedades que são realmente código nos bastidores. Já usamos o uppercased()método das strings, por exemplo, mas também há uma propriedade chamada capitalized que é calculada conforme a necessidade, em vez de cada string sempre armazenar uma versão em maiúscula de si mesma.
// Para fazer uma propriedade computada, coloque uma chave aberta após sua propriedade e use getou setpara fazer uma ação acontecer no momento apropriado. Por exemplo, se quiséssemos adicionar uma ageInDogYearspropriedade que retornasse automaticamente a idade de uma pessoa multiplicada por sete, faríamos isso:

struct Person3 {
    var age: Int

    var ageInDogYears: Int {
        get {
            return age * 7
        }
    }
}

var fan1 = Person3(age: 25)
print(fan1.ageInDogYears)

// Propriedades computadas são cada vez mais comuns no código da Apple, mas menos comuns no código do usuário.

// Nota: Se você pretende usá-los apenas para leitura de dados, basta remover a getparte completamente, assim:
struct Person4 {
    var age: Int

    var ageInDogYears: Int {
        return age * 7
    }
}

var fan2 = Person4(age: 25)
print(fan2.ageInDogYears)
