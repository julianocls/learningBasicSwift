//: [Previous](@previous)

import Foundation

// Inicializadores são métodos especiais que fornecem maneiras diferentes de criar sua estrutura. Todos os structs vêm com um por padrão, chamado de inicializador de membro – isso solicita que você forneça um valor para cada propriedade ao criar o struct.
// Você pode ver isso se criarmos uma Userestrutura que tenha uma propriedade:

struct User {
    var username: String
    var password: String
}

// Quando criamos uma dessas estruturas, devemos fornecer um nome de usuário:

var user = User(username: "twostraws", password: "123")

print(user.username)
print(user.password)


// Podemos fornecer nosso próprio inicializador para substituir o padrão. Por exemplo, podemos querer criar todos os novos usuários como “Anônimos” e imprimir uma mensagem, como esta:

struct User2 {
    var username: String

    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}

// Você não escreve funcantes dos inicializadores, mas precisa certificar-se de que todas as propriedades tenham um valor antes que o inicializador termine.
// Agora nosso inicializador não aceita parâmetros, precisamos criar a estrutura assim:

var user2 = User2()
user2.username = "twostraws"


// MARK: Self

// Dentro dos métodos, você obtém uma constante especial chamada self, que aponta para qualquer instância da estrutura que está sendo usada no momento. Esse selfvalor é particularmente útil quando você cria inicializadores que têm os mesmos nomes de parâmetro que sua propriedade.
// Por exemplo, se você cria um Personstruct com uma namepropriedade e tenta escrever um inicializador que aceita um nameparâmetro, selfajuda a distinguir entre a propriedade e o parâmetro –  self.namerefere-se à propriedade, enquanto namerefere-se ao parâmetro.
// Aqui está isso no código:

struct Person {
    var name: String

    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}

Person(name: "Stone")


// MARK: Lazy properties

//  Como otimização de desempenho, o Swift permite que você crie algumas propriedades apenas quando forem necessárias. Como exemplo, considere esta FamilyTreeestrutura - ela não faz muito, mas, em teoria, criar uma árvore genealógica para alguém leva muito tempo:

struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

// Podemos usar essa FamilyTreestruct como uma propriedade dentro de uma Personstruct, assim:
// Mas e se nem sempre precisássemos da árvore genealógica de uma pessoa em particular? Se adicionarmos a lazypalavra-chave à familyTreepropriedade, o Swift só criará o FamilyTreestruct quando for acessado pela primeira vez:

struct Person3 {
    var name: String
    lazy var familyTree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}

var ed = Person3(name: "Ed")

// Então, se você quiser ver “Criando árvore genealógica!” mensagem, você precisa acessar a propriedade pelo menos uma vez:
ed.familyTree


// MARK: Static properties and method

// Todas as propriedades e métodos que criamos até agora pertenceram a instâncias individuais de structs, o que significa que, se tivéssemos uma Studentstruct, poderíamos criar várias instâncias de alunos, cada uma com suas próprias propriedades e métodos:

struct Student {
    var name: String

    init(name: String) {
        self.name = name
    }
}

let eds = Student(name: "Eds")
let taylor = Student(name: "Taylor")

// Você também pode pedir ao Swift para compartilhar propriedades e métodos específicos em todas as instâncias do struct declarando-os como static .
// Para testar isso, vamos adicionar uma propriedade estática ao Studentstruct para armazenar quantos alunos estão na classe. Sempre que criarmos um novo aluno, adicionaremos um a ele:

struct Student2 {
    static var classSize = 0
    var name: String

    init(name: String) {
        self.name = name
        Student2.classSize += 1
    }
}

// Como a classSizepropriedade pertence ao próprio struct e não às instâncias do struct, precisamos lê-lo usando Student.classSize:

print(Student2.classSize)
print(Student2.classSize)


// MARK: Access control

/*
O controle de acesso permite restringir qual código pode usar propriedades e métodos. Isso é importante porque você pode querer impedir que as pessoas leiam uma propriedade diretamente, por exemplo.
Poderíamos criar um Personstruct que tenha uma idpropriedade para armazenar seu número de previdência social:
Depois que essa pessoa for criada, podemos torná- idla privada para que você não possa lê-la de fora da estrutura - tentar escrever ed.idsimplesmente não funcionará.
Basta usar a palavra- private chave.
Agora apenas os métodos internos Personpodem ler a idpropriedade. Por exemplo.
Outra opção comum é public, que permite que todos os outros códigos usem a propriedade ou método.
*/

struct Person2 {
    private var id: String

    init(id: String) {
        self.id = id
    }

    func identify() -> String {
        return "My social security number is \(id)"
    }
}

let ed2 = Person2(id: "12345")
print(ed2.identify())
















