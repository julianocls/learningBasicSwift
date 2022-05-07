//: [Previous](@previous)

import Foundation


// MARK: Creating your own classes

/*
As classes são semelhantes a structs, pois permitem criar novos tipos com propriedades e métodos, mas elas têm cinco diferenças importantes e vou orientá-lo em cada uma dessas diferenças, uma de cada vez.

A primeira diferença entre classes e structs é que as classes nunca vêm com um inicializador de membro. Isso significa que, se você tiver propriedades em sua classe, deverá sempre criar seu próprio inicializador.

Por exemplo:
*/

class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

// Criar instâncias dessa classe parece exatamente como se fosse uma estrutura:
let poppy = Dog(name: "Poppy", breed: "Poodle")
print(poppy.name + " / " + poppy.breed)


// MARK: Class inheritance

/*
A segunda diferença entre classes e structs é que você pode criar uma classe baseada em uma classe existente – ela herda todas as propriedades e métodos da classe original e pode adicionar suas próprias no topo.

Isso é chamado de herança de classe ou subclasse , a classe da qual você herda é chamada de classe “pai” ou “super”, e a nova classe é chamada de classe “filho”.

Aqui está a Dogclasse que acabamos de criar:
*/

class Dog2 {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

/*
Poderíamos criar uma nova classe baseada naquela chamada Poodle. Ele herdará as mesmas propriedades e inicializador que Dog por padrão:

 No entanto, também podemos fornecer Poodleseu próprio inicializador. Sabemos que sempre terá a raça “Poodle”, para que possamos fazer um novo inicializador que precise apenas de uma namepropriedade. Melhor ainda, podemos fazer o Poodleinicializador chamar o Doginicializador diretamente para que aconteça a mesma configuração:
*/

class Poodle2: Dog2 {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}

let dogs = Poodle2(name: "Cristal")
print(dogs.name + " / " + dogs.breed )

/*
Por razões de segurança, o Swift sempre faz você chamar super.init()de classes filhas – apenas no caso de a classe pai fazer algum trabalho importante quando é criada.
*/


// MARK: Overriding method

/*
As classes filhas podem substituir os métodos pai por suas próprias implementações – um processo conhecido como overriding . Aqui está uma Dogclasse trivial com um makeNoise()método:
*/

class Dog3 {
    func makeNoise() {
        print("Woof!")
    }
}

class Poodle3: Dog3 {

}
let dog3 = Dog3()
dog3.makeNoise()

/*
Se criarmos uma nova Poodleclasse que herda de Dog, ela herdará o makeNoise()método. Então, isso imprimirá “Woof!”:
A substituição de método nos permite alterar a implementação de makeNoise()para a Poodle classe.
O Swift exige que usemos override funcem vez de apenas funcsubstituir um método - ele impede que você substitua um método por acidente, e você receberá um erro se tentar substituir algo que não existe na classe pai:
*/

class Poodle4: Dog3 {
    override func makeNoise() {
        print("Yip!")
    }
}

let poppy4 = Poodle4()
poppy4.makeNoise()

// Com essa alteração, poppy.makeNoise()imprimirá “Yip!” em vez de “Uau!”.


// MARK: Final Classes

/*
Embora a herança de classe seja muito útil – e de fato grande parte das plataformas da Apple exijam que você a use – às vezes você deseja impedir que outros desenvolvedores construam sua própria classe com base na sua.

Swift nos dá uma palavra- finalchave apenas para este propósito: quando você declara uma classe como final, nenhuma outra classe pode herdar dela. Isso significa que eles não podem substituir seus métodos para alterar seu comportamento – eles precisam usar sua classe do jeito que foi escrita.

Para fazer uma classe final, basta colocar a finalpalavra-chave antes dela, assim:
*/

final class Dog4 {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}


// MARK: Copying objects

/*
A terceira diferença entre classes e structs é como elas são copiadas. Quando você copia um struct, tanto o original quanto a cópia são coisas diferentes – mudar um não mudará o outro. Quando você copia uma classe , tanto o original quanto a cópia apontam para a mesma coisa, portanto, alterar um altera o outro.

Por exemplo, aqui está uma classe simples Singerque tem uma namepropriedade com um valor padrão:
*/

class Singer2 {
    var name = "Taylor"
}

// Se criarmos uma instância dessa classe e imprimirmos seu nome, obteremos “Taylor Swift”:

var singer = Singer2()
print(singer.name)

// Agora vamos criar uma segunda variável a partir da primeira e alterar seu nome:

var singerCopy = singer
singerCopy.name = "Justin"

/*
 Por causa da forma como as classes funcionam, ambos singere singerCopyapontam para o mesmo objeto na memória, então quando imprimirmos o nome do cantor novamente veremos “Justin Bieber”:
*/

print(singer.name)

// Por outro lado, se Singerfosse uma struct, teríamos “Taylor” impresso uma segunda vez:


// MARK: Deinitializers

/*
A quarta diferença entre classes e structs é que as classes podem ter desinicializadores – código que é executado quando uma instância de uma classe é destruída.

Para demonstrar isso, aqui está uma Personclasse com uma namepropriedade, um inicializador simples e um printGreeting()método que imprime uma mensagem:
*/

class Person {
    var name = "John Doe"
    var index: Int

    init(index: Int) {
        self.index = index
        print("\(index) - \(name) is alive!")
    }

    // E agora para o desinicializador. Isso será chamado quando a Personinstância estiver sendo destruída:
    deinit {
        print("\(index) - \(name) is no more!")
    }
    
    func printGreeting() {
        print("Hello, I'm \(name)")
    }
}

/*Vamos criar algumas instâncias da Personclasse dentro de um loop, porque cada vez que o loop dá uma volta, uma nova pessoa será criada e destruída:
*/

for i in 1...3 {
    let person = Person(index: i)
    person.printGreeting()
    print("--------------------------------------------")
}


// MARK: Mutability

/*
A diferença final entre classes e structs é a maneira como eles lidam com constantes. Se você tiver uma estrutura constante com uma propriedade variável, essa propriedade não poderá ser alterada porque a estrutura em si é constante.

No entanto, se você tiver uma classe constante com uma propriedade variável, essa propriedade poderá ser alterada. Por causa disso, as classes não precisam da mutatingpalavra-chave com métodos que alteram as propriedades; isso só é necessário com structs.

Essa diferença significa que você pode alterar qualquer propriedade de variável em uma classe mesmo quando a classe é criada como uma constante – este é um código perfeitamente válido:
*/

class Singer3 {
    var name = "Taylor Swift"
}

let taylor3 = Singer3()
taylor3.name = "Ed Sheeran"
print(taylor3.name)

//Se você quiser impedir que isso aconteça, você precisa tornar a propriedade constante:
class Singer4 {
    let name = "Taylor Swift"
}


