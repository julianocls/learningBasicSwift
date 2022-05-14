//: [Previous](@previous)

import Foundation

/*
Como as classes podem herdar umas das outras (por exemplo CountrySinger, podem herdar de Singer), isso significa que uma classe é efetivamente um superconjunto de outra: a classe B tem todas as coisas que A tem, com alguns extras. Isso, por sua vez, significa que você pode tratar B como tipo B ou como tipo A, dependendo de suas necessidades.

Confuso? Vamos tentar algum código:
*/

class Album {
    var name: String

    init(name: String) {
        self.name = name
    }
}

class StudioAlbum: Album {
    var studio: String

    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
}

class LiveAlbum: Album {
    var location: String

    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
}

/*
Isso define três classes: álbuns, álbuns de estúdio e álbuns ao vivo, com os dois últimos herdando de Album. Como qualquer instância de LiveAlbumé herdada Albumdela pode ser tratada como Albumou LiveAlbum– são as duas ao mesmo tempo. Isso é chamado de "polimorfismo", mas significa que você pode escrever código assim:
*/

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

/*
 Lá criamos um array que contém apenas álbuns, mas colocamos dentro dele dois álbuns de estúdio e um álbum ao vivo. Isso está perfeitamente bem em Swift porque todos eles são descendentes da Albumclasse, então eles compartilham o mesmo comportamento básico.

Podemos levar isso um passo adiante para realmente demonstrar como o polimorfismo funciona. Vamos adicionar um getPerformance()método a todas as três classes:
*/

class Album {
    var name: String

    init(name: String) {
        self.name = name
    }

    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum: Album {
    var studio: String

    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum: Album {
    var location: String

    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }

    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

/*
 O getPerformance()método existe na Albumclasse, mas ambas as classes filhas o substituem. Quando criamos um array que contém Albums, na verdade o estamos preenchendo com subclasses de albums: LiveAlbume StudioAlbum. Eles entram na matriz muito bem porque herdam da Albumclasse, mas nunca perdem sua classe original. Então, poderíamos escrever um código assim:
*/

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

for album in allAlbums {
    print(album.getPerformance())
}

/*
 Isso usará automaticamente a versão de substituição getPerformance()dependendo da subclasse em questão. Isso é polimorfismo em ação: um objeto pode funcionar como sua classe e suas classes pai, tudo ao mesmo tempo.

Convertendo tipos com typecasting
Muitas vezes você descobrirá que tem um objeto de um certo tipo, mas na verdade você sabe que é um tipo diferente. Infelizmente, se o Swift não souber o que você sabe, ele não construirá seu código. Então, existe uma solução, e isso se chama typecasting: converter um objeto de um tipo para outro.

Provavelmente, você está lutando para pensar por que isso pode ser necessário, mas posso dar um exemplo muito simples:
*/

for album in allAlbums {
    print(album.getPerformance())
}

/*
 Esse foi o nosso loop de alguns minutos atrás. A allAlbumsmatriz contém o tipo Album, mas sabemos que na verdade ela contém uma das subclasses: StudioAlbumou LiveAlbum. O Swift não sabe disso, então se você tentar escrever algo assim print(album.studio), ele se recusará a construir porque apenas StudioAlbumos objetos têm essa propriedade.

Typecasting no Swift vem em três formas, mas na maioria das vezes você encontrará apenas duas: as?e as!, conhecido como downcasting opcional e downcasting forçado. O primeiro significa "Acho que essa conversão pode ser verdadeira, mas pode falhar" e o segundo significa "Sei que essa conversão é verdadeira e fico feliz que meu aplicativo falhe se estiver errado".

Nota: quando digo "conversão" não quero dizer que o objeto literalmente se transforma. Em vez disso, está apenas convertendo como o Swift trata o objeto – você está dizendo ao Swift que um objeto que ele pensava ser do tipo A é na verdade do tipo E.

A pergunta e os pontos de exclamação devem dar uma dica do que está acontecendo, porque isso é muito semelhante ao território opcional. Por exemplo, se você escrever isso:
*/

for album in allAlbums {
    let studioAlbum = album as? StudioAlbum
}

/*
 Swift fará com que studioAlbumtenha o tipo de dados StudioAlbum?. Ou seja, um álbum de estúdio opcional: a conversão pode ter funcionado, nesse caso você tem um álbum de estúdio com o qual pode trabalhar, ou pode ter falhado, nesse caso você tem zero.

Isso é mais comumente usado if letpara desempacotar automaticamente o resultado opcional, assim:
*/

for album in allAlbums {
    print(album.getPerformance())

    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
}

/*
 Isso passará por todos os álbuns e imprimirá seus detalhes de desempenho, porque isso é comum à Albumclasse e a todas as suas subclasses. Em seguida, ele verifica se pode converter o albumvalor em um StudioAlbume, se puder, imprime o nome do estúdio. A mesma coisa é feita para o LiveAlbumna matriz.

O downcast forçado é quando você tem certeza de que um objeto de um tipo pode ser tratado como um tipo diferente, mas se você estiver errado, seu programa simplesmente travará. O downcast forçado não precisa retornar um valor opcional, porque você está dizendo que a conversão definitivamente funcionará – se você estiver errado, significa que você escreveu seu código errado.

Para demonstrar isso de uma maneira não-crash, vamos remover o álbum ao vivo para que tenhamos apenas álbuns de estúdio no array:
*/

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")

var allAlbums: [Album] = [taylorSwift, fearless]

for album in allAlbums {
    let studioAlbum = album as! StudioAlbum
    print(studioAlbum.studio)
}

/*
 Obviamente, esse é um exemplo artificial, porque se esse realmente fosse seu código, você apenas mudaria allAlbumspara que ele tivesse o tipo de dados [StudioAlbum]. Ainda assim, ele mostra como o downcasting forçado funciona e o exemplo não falhará porque faz as suposições corretas.

O Swift permite que você faça downcast como parte do loop de array, que nesse caso seria mais eficiente. Se você quisesse escrever esse downcast forçado no nível do array, você escreveria isto:
*/

for album in allAlbums as! [StudioAlbum] {
    print(album.studio)
}

/*
 Isso não precisa mais reduzir todos os itens dentro do loop, porque isso acontece quando o loop começa. Novamente, é melhor você estar certo de que todos os itens na matriz são StudioAlbums, caso contrário, seu código falhará.

O Swift também permite downcasting opcional no nível do array, embora seja um pouco mais complicado porque você precisa usar o operador nil coalescing para garantir que sempre haja um valor para o loop. Aqui está um exemplo:
*/

for album in allAlbums as? [LiveAlbum] ?? [LiveAlbum]() {
    print(album.location)
}

/*
 O que isso significa é, “tente converter allAlbumspara ser uma matriz de LiveAlbumobjetos, mas se isso falhar, apenas crie uma matriz vazia de álbuns ao vivo e use-a” – ou seja, não faça nada.

Convertendo tipos comuns com inicializadores
Typecasting é útil quando você sabe algo que o Swift não sabe, por exemplo, quando você tem um objeto do tipo Aque o Swift acha que é realmente type B. No entanto, typecasting é útil apenas quando esses tipos realmente são o que você diz – você não pode forçar um tipo Aem um tipo Zse eles não estiverem realmente relacionados.

Por exemplo, se você tiver um inteiro chamado number, não poderá escrever um código como este para torná-lo uma string:
*/

let number = 5
let text = number as! String

/*
 Ou seja, você não pode forçar um inteiro em uma string, porque eles são dois tipos completamente diferentes. Em vez disso, você precisa criar uma nova string alimentando-a com o inteiro, e o Swift sabe como converter os dois. A diferença é sutil: este é um novo valor, e não apenas uma reinterpretação do mesmo valor.

Então, esse código deve ser reescrito assim:
*/

let number = 5
let text = String(number)
print(text)

/*
 Isso funciona apenas para alguns tipos de dados internos do Swift: você pode converter inteiros e flutuantes em strings e vice-versa, por exemplo, mas se você criou duas estruturas personalizadas, o Swift não pode converter magicamente um no outro – você precisa escrever esse código você mesmo.
*/
