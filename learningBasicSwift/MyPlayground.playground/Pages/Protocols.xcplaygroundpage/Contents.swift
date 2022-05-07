//: [Previous](@previous)

import Foundation

// MARK: Protocolos

/*
Os protocolos são uma maneira de descrever quais propriedades e métodos algo deve ter. Você então informa ao Swift quais tipos usam esse protocolo – um processo conhecido como adoção ou conformidade com um protocolo.
Por exemplo, podemos escrever uma função que aceita algo com uma idpropriedade, mas não nos importamos precisamente com o tipo de dado usado. Começaremos criando um Identifiableprotocolo, que exigirá que todos os tipos em conformidade tenham uma idstring que possa ser lida (“get”) ou escrita (“set”):
*/

protocol Identifiable {
    var id: String { get set }
}

/*
Não podemos criar instâncias desse protocolo - é uma descrição do que queremos, em vez de algo que podemos criar e usar diretamente. Mas podemos criar uma estrutura que esteja de acordo com ela:
*/

struct User: Identifiable {
    var id: String
}

// Por fim, escreveremos uma displayID()função que aceita qualquer Identifiableobjeto:
func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}


// MARK: Protocol inharitance

/*
Um protocolo pode herdar de outro em um processo conhecido como herança de protocolo . Ao contrário das classes, você pode herdar de vários protocolos ao mesmo tempo antes de adicionar suas próprias personalizações.
Vamos definir três protocolos: Payablerequer tipos em conformidade para implementar um calculateWages()método, NeedsTrainingrequer tipos em conformidade para implementar um study()método e HasVacationrequer tipos em conformidade para implementar um takeVacation()método:
*/

protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

/*
 Agora podemos fazer com que novos tipos estejam em conformidade com esse único protocolo, em vez de cada um dos três protocolos individuais.
 Agora podemos criar um único Employeeprotocolo que os reúne em um protocolo. Não precisamos adicionar nada no topo, então vamos apenas escrever chaves de abertura e fechamento:
*/

protocol Employee: Payable, NeedsTraining, HasVacation { }


// MARK: Extensions

/*
As extensões permitem que você adicione métodos a tipos existentes, para fazê-los fazer coisas para as quais não foram originalmente projetados.
Por exemplo, poderíamos adicionar uma extensão ao Inttipo para que ele tenha um squared()método que retorne o número atual multiplicado por ele mesmo:
*/

extension Int {
    func squared() -> Int {
        return self * self
    }
}

// Para tentar isso, basta criar um inteiro e você verá que agora tem um squared()método:

let number = 8
let number2 = 7

number.squared()

/*
 O Swift não permite adicionar propriedades armazenadas em extensões, portanto, você deve usar propriedades computadas. Por exemplo, poderíamos adicionar uma nova isEvenpropriedade computada a inteiros que retornasse true se contiver um número par:
*/

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

number.isEven
number2.isEven


// MARK: Protocol Extensions

/*
Os protocolos permitem que você descreva quais métodos algo deve ter, mas não fornece o código interno. As extensões permitem que você forneça o código dentro de seus métodos, mas afetam apenas um tipo de dados – você não pode adicionar o método a muitos tipos ao mesmo tempo.
As extensões de protocolo resolvem esses dois problemas: são como extensões regulares, exceto que, em vez de estender um tipo específico, como Intvocê estende um protocolo inteiro para que todos os tipos em conformidade recebam suas alterações.
Por exemplo, aqui está um array e um conjunto contendo alguns nomes:
*/

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

/*
Os arrays e conjuntos do Swift estão em conformidade com um protocolo chamado Collection, então podemos escrever uma extensão para esse protocolo para adicionar um summarize()método para imprimir a coleção ordenadamente
*/

extension Collection {
    func summarize() {
        print("There are \(count) of us:")

        for name in self {
            print(name)
        }
    }
}

// Ambos Arraye Setagora terão esse método, para que possamos experimentá-lo:

pythons.summarize()
beatles.summarize()


// MARK: Protocol-Oriented programming

/*
As extensões de protocolo podem fornecer implementações padrão para nossos próprios métodos de protocolo. Isso facilita a conformidade dos tipos com um protocolo e permite uma técnica chamada “programação orientada a protocolos” – elaborando seu código em torno de protocolos e extensões de protocolo.
Primeiro, aqui está um protocolo chamado Identifiableque requer que qualquer tipo em conformidade tenha uma idpropriedade e um identify()método:
*/

protocol Identifiable2 {
    var id: String { get set }
    func identify()
}

// Poderíamos fazer com que cada tipo em conformidade escrevesse seu próprio identify()método, mas as extensões de protocolo nos permitem fornecer um padrão:
extension Identifiable2 {
    func identify() {
        print("My ID is \(id).")
    }
}

// Agora, quando criamos um tipo que está em conformidade com Identifiableele, obtém identify()automaticamente:
struct User2: Identifiable2 {
    var id: String
}

let twostraws = User2(id: "8572349")
twostraws.identify()






















