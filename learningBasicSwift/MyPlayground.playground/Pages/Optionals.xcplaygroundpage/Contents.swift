//: [Previous](@previous)

import Foundation

// MARK: Optionals

/*
Usamos tipos como Intpara armazenar valores como 5. Mas se você quisesse armazenar uma agepropriedade para usuários, o que faria se não soubesse a idade de alguém?
Você pode dizer “bem, vou armazenar 0”, mas então você ficaria confuso entre bebês recém-nascidos e pessoas cuja idade você não conhece. Você poderia usar um número especial como 1000 ou -1 para representar “desconhecido”, ambos são idades impossíveis, mas então você realmente se lembraria desse número em todos os lugares em que é usado?
A solução do Swift é chamada de optionals e você pode fazer opcionais de qualquer tipo. Um inteiro opcional pode ter um número como 0 ou 40, mas pode não ter valor algum – pode estar literalmente ausente, o que está nilem Swift.
Para tornar um tipo opcional, adicione um ponto de interrogação depois dele. Por exemplo, podemos fazer um inteiro opcional como este:
*/

var age: Int? = nil

// Isso não contém nenhum número – não contém nada. Mas se mais tarde aprendermos essa idade, podemos usá-la:
age = 38


// MARK: Unwrapping Optionals

/*
Strings opcionais podem conter uma string como “Hello” ou podem ser nulas – nada.
Considere esta string opcional:
*/

var name: String? = nil

/*
O que acontece se usarmos name.count? Uma string real tem uma count propriedade que armazena quantas letras ela tem, mas isso é nil– é uma memória vazia, não uma string, então ela não tem um count.
Por isso, tentar ler name.count não é seguro e o Swift não permite. Em vez disso, devemos olhar dentro do opcional e ver o que está lá – um processo conhecido como unwrapping .
Uma maneira comum de desempacotar opcionais é com if let sintaxe, que desempacota com uma condição. Se houver um valor dentro do opcional, você poderá usá-lo, mas se não houver, a condição falhará.
Por exemplo:
*/
 
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}

/*
Se name contém uma string, ela será colocada dentro unwrapped como regular String e podemos ler sua count propriedade dentro da condição. Alternativamente, se name estiver vazio, o else código será executado.
*/

name = "unwrapped"

if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}


// MARK: Unwrapped with guard

/*
Uma alternativa para if let é guard let, que também desempacota opcionais. guard let irá desempacotar um opcional para você, mas se encontrar nil dentro dele, espera que você saia da função, loop ou condição em que você o usou.
No entanto, a principal diferença entre if let e guard let é que seu opcional desempacotado permanece utilizável após o guard código.
Vamos experimentá-lo com uma greet() função. Isso aceitará uma string opcional como seu único parâmetro e tentará desembrulhar, mas se não houver nada dentro, imprimirá uma mensagem e sair á. Como os opcionais desempacotados usando guard let permanecem após o término guard, podemos imprimir a string desempacotada no final da função:
*/
                                
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }

    print("Hello, \(unwrapped)!")
}

/*
Usando guard letpermite que você lide com problemas no início de suas funções e saia imediatamente. Isso significa que o resto da sua função é o caminho feliz – o caminho que seu código segue se tudo estiver correto.
*/
greet(nil)
greet("unwrapping with guard let")


// MARK: Unwrapping force

/*
Opcionais representam dados que podem ou não estar lá, mas às vezes você sabe com certeza que um valor não é nulo. Nesses casos, o Swift permite que você force o desempacotamento do opcional: converta-o de um tipo opcional para um tipo não opcional.
Por exemplo, se você tem uma string que contém um número, você pode convertê-la para algo Int assim:
*/

let str = "5"
let num = Int(str)

/*
Isso torna num opcional Int porque você pode ter tentado converter uma string como “Fish” em vez de “5”.
Mesmo que o Swift não tenha certeza de que a conversão funcionará, você pode ver que o código é seguro para que você possa forçar o desempacotamento do resultado escrevendo "!" depois Int(str), assim:
*/

let num2 = Int(str)!

/*
O Swift desempacotará imediatamente o opcional e fará um regular Intem vez de um Int?. Mas se você estiver errado – se str for algo que não pode ser convertido para um número inteiro – seu código irá travar.
Como resultado, você deve forçar o desempacotamento apenas quando tiver certeza de que é seguro – há uma razão pela qual é frequentemente chamado de operador de falha.
*/


// MARK: Implicitly unwrepped optionals

/*
Como opcionais regulares, opcionais desempacotados implicitamente podem conter um valor ou podem ser nil. No entanto, ao contrário dos opcionais regulares, você não precisa desembrulhar eles para usá-los: você pode usá-los como se não fossem opcionais.
Opcionais implicitamente desempacotados são criados adicionando um ponto de exclamação após o nome do seu tipo, assim:
*/

let age2: Int! = nil

/*
Como eles se comportam como se já estivessem desempacotados, você não precisa if let nem guard let para usar opcionais desempacotados implicitamente. No entanto, se você tentar usá-los e eles não tiverem valor – se tiverem nil– seu código falha.
Opcionais implícitamente desempacotados existem porque às vezes uma variável começará a vida como nil, mas sempre terá um valor antes que você precise usá-la. Como você sabe que eles terão um valor quando você precisar deles, é útil não ter que escrever if let o tempo todo.
Dito isto, se você puder usar opcionais regulares, geralmente é uma boa ideia.
*/


// MARK: Nil coalescing

/*
O operador nil coalescing desempacota um opcional e retorna o valor dentro se houver um. Se não houver um valor – se o opcional era nil– então um valor padrão é usado. De qualquer forma, o resultado não será opcional: será o valor de dentro do opcional ou o valor padrão usado como backup.
Aqui está uma função que aceita um inteiro como seu único parâmetro e retorna uma string opcional:
*/

func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

/*
Se chamarmos isso com ID 15, retornaremos nilporque o usuário não é reconhecido, mas com nil coalescing podemos fornecer um valor padrão de "Anonymous" assim:
*/

let user = username(for: 15) ?? "Anonymous"

/*
Isso verificará o resultado que retorna da username()função: se for uma string, ela será desempacotada e colocada em user, mas se tiver nildentro, será usado "Anônimo".
*/


// MARK: Optionals chaining

/*
Swift nos fornece um atalho ao usar opcionais: se você quiser acessar algo como a.b.c e d para opcional, você pode escrever um ponto de interrogação depois dele para habilitar o encadeamento opcional : a.b?.c.
Quando esse código for executado, o Swift verificará se b tem um valor, e se for nil o resto da linha será ignorado – o Swift retornará nil imediatamente. Mas se tiver um valor, será desempacotado e a execução continuará.
Para ver isso, aqui está uma matriz de nomes:
*/
                            
var names = ["John", "Paul", "George", "Ringo"]
                        
/*
Vamos usar a first propriedade desse array, que retornará o primeiro nome se houver um ou nil se o array estiver vazio. Podemos então chamar uppercased() o resultado para torná-lo uma string maiúscula:
*/
                            
var beatle = names.first?.uppercased()
  
/*
Esse ponto de interrogação é um encadeamento opcional - se first retornar nil, o Swift não tentará colocá-lo em maiúsculas e será definido beatle como nil imediatamente.
*/


// MARK: Optionals TRY

// Quando estávamos falando sobre lançar funções, vimos este código:
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

// Isso executa uma função de lançamento, usando do, trye catchpara lidar com erros normalmente.
// Existem duas alternativas para try, ambas farão mais sentido agora que você entende os opcionais e força o desempacotamento.
// A primeira é try?, e transforma funções de lançamento em funções que retornam um opcional. Se a função lançar um erro, você será enviado nilcomo resultado, caso contrário, você obterá o valor de retorno encapsulado como opcional.
// Usando try?podemos executar checkPassword()assim:


if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}

// A outra alternativa é try!, que você pode usar quando tiver certeza de que a função não falhará. Se a função lançar um erro, seu código irá travar.

// Usando try!, podemos reescrever o código para isso:

try! checkPassword("sekrit")
print("OK!")


// MARK: Failable initializers

// Ao falar sobre force unwrapping, usei este código:

let str3 = "5"
let num3 = Int(str)

/*
Isso converte uma string em um inteiro, mas como você pode tentar passar qualquer string para lá, o que você realmente recebe de volta é um inteiro opcional .

Este é um inicializador com falha: um inicializador que pode funcionar ou não. Você pode escrevê-los em suas próprias estruturas e classes usando init?() em vez de init(), e retornar nil se algo der errado. O valor de retorno será então um opcional do seu tipo, para você desembrulhar como quiser.

Como exemplo, poderíamos codificar uma Person estrutura que deve ser criada usando uma string de ID de nove letras. Se algo diferente de uma string de nove letras for usado, retornaremos nil, caso contrário, continuaremos normalmente.

Aqui está isso em Swift:
*/


struct Person {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}


// MARK: Typecasting

// O Swift deve sempre saber o tipo de cada uma de suas variáveis, mas às vezes você sabe mais informações do que o Swift. Por exemplo, aqui estão três classes:

class Animal { }
class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}

// Podemos criar alguns peixes e alguns cachorros e colocá-los em um array, assim:
let pets = [Fish(), Dog(), Fish(), Dog()]

/*
Swift pode ver ambos Fish e Dog herdar da Animal classe, então ele usa inferência de tipo para fazer pet sum array de Animal.
Se quisermos fazer um loop no pets array e pedir que todos os cães ladram, precisamos executar um typecast: Swift verificará se cada animal de estimação é um Dog objeto e, se for, podemos chamar makeNoise().
Isso usa uma nova palavra-chave chamada as?, que retorna um opcional: será nil se o typecast falhou, ou um tipo convertido caso contrário.
Veja como escrevemos o loop em Swift:
*/


for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}







