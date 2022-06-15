//: [Previous](@previous)

import Foundation


/*
 Capture listas no Swift: qual é a diferença entre referências fracas, fortes e sem dono?
Fraco vs forte vs sem dono – saiba a diferença nos fechamentos


As listas de captura vêm antes da lista de parâmetros de um encerramento em seu código e capturam valores do ambiente como fortes, fracos ou sem dono. Nós os usamos muito , principalmente para evitar ciclos de referência fortes – também conhecidos como ciclos de retenção.
Decidir qual usar não é fácil quando você está aprendendo, então você pode gastar tempo tentando descobrir forte versus fraco, ou fraco versus sem dono, mas à medida que você progride em seu aprendizado, você começará a perceber que muitas vezes há apenas um certo escolha.

Primeiro, vamos dar uma olhada no problema. Primeiro, aqui está uma classe simples: */

class Singer {
    func playSong() {
        print("Shake it off!")
    }
}

// Segundo, aqui está uma função que cria uma instância de Singer, cria um encerramento que usa o playSong()método do cantor e retorna esse encerramento para usarmos em outro lugar:

func sing() -> () -> Void {
    let taylor = Singer()

    let singing = {
        taylor.playSong()
        return
    }

    return singing
}

// Finalmente, podemos chamar sing() para obter de volta uma função que podemos chamar onde quisermos playSong()imprimir:
// Isso imprimirá "Shake it off!" graças à chamada para singFunction().
let singFunction = sing()
singFunction()


/*
Captura forte
 
A menos que você peça algo especial, Swift usa captura forte . Isso significa que o fechamento capturará quaisquer valores externos usados ​​dentro do fechamento e garantirá que eles nunca sejam destruídos.

Olhe novamente para a nossa função sing() acima:

Essa taylorconstante é feita dentro da sing()função, então normalmente seria destruída quando a função terminasse. No entanto, ele é usado dentro do encerramento, o que significa que o Swift irá automaticamente garantir que ele permaneça ativo enquanto o encerramento existir em algum lugar, mesmo após o retorno da função.

Esta é uma forte captura em ação. Se Swift permitisse taylorser destruído, então o encerramento não seria mais seguro para chamar – seu taylor.playSong()método não seria mais válido.



Captura fraca

Swift nos permite especificar uma lista de captura para determinar como os valores usados ​​dentro da closure devem ser capturados. A alternativa mais comum à captura forte é chamada de captura fraca e muda duas coisas:

Valores fracamente capturados não são mantidos vivos pelo encerramento, então eles podem ser destruídos e definidos como nil.
Como resultado de 1, valores fracamente capturados são sempre opcionais em Swift. Isso impede que você suponha que eles estão presentes quando, na verdade, podem não estar.
Podemos modificar nosso exemplo para usar captura fraca e você verá uma diferença imediata:*/

func sing2() -> () -> Void {
    let taylor = Singer()

    let singing = { [weak taylor] in
        taylor?.playSong()
        return
    }

    return singing
}

let singFunction2 = sing2()
singFunction2()

 /*
Essa [weak taylor]parte é a nossa lista de captura, que é uma parte específica dos encerramentos onde damos instruções específicas sobre como os valores devem ser capturados. Aqui estamos dizendo que taylordeve ser capturado fracamente, e é por isso que precisamos usar taylor?.playSong()– é opcional agora, porque pode ser definido como nil a qualquer momento.

Se você executar o código agora, verá que a chamada singFunction()não imprime mais nada. A razão é que taylorexiste apenas dentro sing()de , porque o fechamento que ele retorna não o mantém forte.

Para ver esse comportamento em ação, tente mudar sing()para isto:*/

func sing3() -> () -> Void {
    let taylor = Singer()

    let singing = { [weak taylor] in
        taylor!.playSong()
        return
    }

    return singing
}

let singFunction3 = sing3()
// singFunction3() - Ao forçar o desempacotamento de taylor dentro do fechamento, fará com que seu código falhe porque taylor se torna nulo.

/*
Captura sem dono
Uma alternativa para weaké unowned, que se comporta mais como opcionais desempacotados implicitamente. Assim como a captura fraca, a captura sem dono permite que os valores se tornem nulos a qualquer momento no futuro. No entanto, você pode trabalhar com eles como se eles sempre estivessem lá – você não precisa desembrulhar opcionais.

Por exemplo:*/

func sing4() -> () -> Void {
    let taylor = Singer()

    let singing = { [unowned taylor] in
        taylor.playSong()
        return
    }

    return singing
}

/*
Isso irá travar de forma semelhante ao nosso exemplo de desempacotamento forçado de antes: unowned taylordiz que eu tenho certeza que taylorsempre existirá durante a vida útil do fechamento que estou enviando de volta, então não preciso segurar a memória, mas na prática taylor, será destruído quase imediatamente para que o código falhe.

Você deve usar unownedcom muito cuidado, de fato.

Problemas comuns
Existem quatro problemas que as pessoas geralmente enfrentam ao usar a captura de fechamento:

Eles não sabem onde usar as listas de captura quando os closures aceitam parâmetros.
 - Eles fazem fortes ciclos de referência, fazendo com que a memória seja consumida.
 - Eles acidentalmente usam referências fortes, principalmente ao usar várias capturas.
 - Eles fazem cópias de fechamentos e compartilham dados capturados.
 - Vamos percorrer cada um deles com alguns exemplos de código, para que você possa ver o que acontece.

 
 
Capturar listas ao lado de parâmetros

 Este é um problema comum quando você está começando com listas de captura, mas felizmente é um que o Swift pega para nós.

Ao usar listas de captura e parâmetros de fechamento juntos, a lista de captura deve sempre vir primeiro, depois a palavra inpara marcar o início do seu corpo de fechamento - tentar colocá-lo após os parâmetros de fechamento impedirá que seu código seja compilado.

Por exemplo:

writeToLog { [weak self] user, message in
    self?.addToLog("\(user) triggered event: \(message)")
}
 
 
 
 
 Ciclos de referência fortes
 Quando a coisa A possui a coisa B, e a coisa B possui a coisa A, você tem o que é chamado de ciclo de referência forte, ou muitas vezes apenas um ciclo de retenção .

 Como exemplo, considere este código:*/

 class House {
     var ownerDetails: (() -> Void)?

     func printDetails() {
         print("This is a great house.")
     }

     deinit {
         print("I'm being demolished!")
     }
 }

/*
 Isso cria uma classe House com uma propriedade (um encerramento), um método e um desinicializador para que imprima uma mensagem quando estiver sendo destruído.

 Agora aqui está uma classe Owner que é a mesma coisa, exceto os detalhes da casa das lojas de fechamento:
*/

class Owner {
     var houseDetails: (() -> Void)?

     func printDetails() {
         print("I own a house.")
     }

     deinit {
         print("I'm dying!")
     }
 }

/*
 Podemos tentar criar duas instâncias dessas classes dentro de um dobloco. Não precisamos de um catchbloco aqui, mas o uso dogarante que eles serão destruídos assim que o }for alcançado:
*/

 print("Creating a house and an owner")

 do {
     let house = House()
     let owner = Owner()
 }

 print("Done")

/*
 Isso deve imprimir “Criando uma casa e um dono”, “Estou morrendo!”, “Estou sendo demolido!”, depois “Feito” – tudo funciona como esperado.

 Agora vamos criar um ciclo de referência forte:
 */


print("Creating a house and an owner")

do {
    let house = House()
    let owner = Owner()
    house.ownerDetails = owner.printDetails
    owner.houseDetails = house.printDetails
}

print("Done")

/*
Agora ele imprimirá "Criando uma casa e um proprietário" e depois "Concluído", sem que nenhum desinicializador seja chamado.

O que está acontecendo aqui é que housetem uma propriedade que aponta para um método de owner, e ownertem uma propriedade que aponta para um método de house, então nenhum deles pode ser destruído com segurança. No código real, isso faz com que a memória não possa ser liberada, conhecida como vazamento de memória , que degrada o desempenho do sistema e pode até fazer com que seu aplicativo seja encerrado.

Para corrigir isso, precisamos criar um novo fechamento e usar captura fraca para um ou ambos os valores, assim:
*/

print("Creating a house and an owner")

do {
    let house = House()
    let owner = Owner()
    house.ownerDetails = { [weak owner] in owner?.printDetails() }
    owner.houseDetails = { [weak house] in house?.printDetails() }
}

print("Done")

/*
Não é necessário ter ambos os valores capturados fracamente – tudo o que importa é que pelo menos um seja, porque permite que o Swift os destrua quando necessário.

Agora, no código de projeto real, é raro encontrar ciclos de referência fortes que sejam tão óbvios, mas isso significa apenas que é ainda mais importante usar captura fraca para evitar o problema inteiramente.

 
 
 
 Referências fortes acidentais
 O padrão do Swift é a captura forte, o que pode causar problemas não intencionais.

 Voltando ao nosso exemplo de canto anterior, considere este código:

 func sing() -> () -> Void {
     let taylor = Singer()
     let adele = Singer()

     let singing = { [unowned taylor, adele] in
         taylor.playSong()
         adele.playSong()
         return
     }

     return singing
 }
 
 Agora temos dois valores sendo capturados pela closure, e ambos os valores estão sendo usados ​​da mesma forma dentro da closure. No entanto, apenas taylorestá sendo capturado como sem dono – adeleestá sendo capturado fortemente, porque a palavra- unownedchave deve ser usada para cada valor capturado na lista.

 Agora, se você quer taylor não ter dono, mas adeleser fortemente capturado, tudo bem. Mas se você quiser que ambos sejam sem dono, você precisa dizer isso:

 [unowned taylor, unowned adele]
 O Swift oferece alguma proteção contra captura acidental, mas é limitado: se você usar self implicitamente dentro de um encerramento, o Swift o forçará a adicionar self.ou self?. para deixar suas intenções claras.

 O uso implícito de self acontece muito no Swift. Por exemplo, esse inicializador chama playSong(), mas o que realmente significa é self.playSong()– a selfparte está implícita no contexto:

 class Singer {
     init() {
         playSong()
     }

     func playSong() {
         print("Shake it off!")
     }
 }
 
 O Swift não permite que você use self fechamentos internos implícitos, o que ajuda a reduzir um tipo comum de ciclo de retenção.

  
 

Cópias de fechamentos
A última coisa que engana as pessoas é a forma como os próprios fechamentos são copiados, porque seus dados capturados são compartilhados entre as cópias.

Por exemplo, aqui está um fechamento simples que captura o numberOfLinesLoggedinteiro criado fora para que ele possa incrementar e imprimir seu valor sempre que for chamado:*/

var numberOfLinesLogged = 0

let logger1 = {
    numberOfLinesLogged += 1
    print("Lines logged: \(numberOfLinesLogged)")
}

logger1()

/*
Isso imprimirá “Linhas registradas: 1” porque chamamos o encerramento no final.

Agora, se fizermos uma cópia desse encerramento, essa cópia compartilhará os mesmos valores de captura que o original, portanto, se chamarmos o original ou a cópia, você verá a contagem de linhas de log aumentando:
*/

let logger2 = logger1
logger2()
logger1()
logger2()

/*
Isso agora imprimirá que 1, 2, 3 e 4 linhas foram registradas, porque ambas logger1e logger2estão apontando para o mesmo valor capturado numberOfLinesLogged.

 Quando usar forte, quando usar fraco, quando usar sem dono
 Agora que você entende como tudo funciona, vamos tentar resumir se devemos usar referências fortes, fracas ou sem dono:

 Se você tiver certeza de que seu valor capturado nunca desaparecerá enquanto o encerramento tiver alguma chance de ser chamado, você poderá usar unowned. Isso é realmente apenas para as poucas vezes em weakque causaria aborrecimentos, mas mesmo quando você poderia usar guard letdentro do encerramento com uma variável fracamente capturada.
 Se você tem uma situação de ciclo de referência forte - onde a coisa A possui a coisa B e a coisa B possui a coisa A - então um dos dois deve usar captura fraca. Isso geralmente deve ser qualquer um dos dois que será destruído primeiro, portanto, se o controlador de exibição A apresentar o controlador de exibição B, o controlador de exibição B pode conter uma referência fraca de volta a A.
 Se não houver chance de um ciclo de referência forte, você pode usar a captura forte. Por exemplo, a execução da animação não fará selfcom que ela seja retida dentro do encerramento da animação, portanto, você pode usar a captura forte.
 Se você não tiver certeza de qual usar, comece weake mude apenas se necessário.


 */
 
