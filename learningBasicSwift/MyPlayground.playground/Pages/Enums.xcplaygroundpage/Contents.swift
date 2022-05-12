//: [Previous](@previous)

import Foundation

// Enumerações – geralmente chamadas apenas de “enum” e pronunciadas “ee-num” – são uma maneira de você definir seu próprio tipo de valor no Swift. Em algumas linguagens de programação, são pequenas coisas simples, mas o Swift adiciona uma enorme quantidade de poder a elas se você quiser ir além do básico.
// Vamos começar com um exemplo simples de antes:

func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}

// Essa função aceita uma string que define o clima atual. O problema é que uma string é uma má escolha para esse tipo de dados - é "chuva", "chuva" ou "chuva"? Ou talvez "chuveiro", "chuva" ou "tempestade"? Pior, e se uma pessoa escrever "Rain" com R maiúsculo e outra pessoa escrever "Ran" porque não estava olhando para o que digitou?
// Os enums resolvem esse problema permitindo que você defina um novo tipo de dados e, em seguida, defina os valores possíveis que ele pode conter. Por exemplo, podemos dizer que existem cinco tipos de clima: sol, nuvem, chuva, vento e neve. Se fizermos disso um enum, significa que o Swift aceitará apenas esses cinco valores - qualquer outra coisa acionará um erro. E os enums nos bastidores geralmente são apenas números simples, que são muito mais rápidos do que strings para computadores trabalharem.

// Vamos colocar isso no código:

enum WeatherType3 {
    case sun, cloud, rain, wind, snow
}

func getHaterStatus2(weather: WeatherType3) -> String? {
    if weather == WeatherType3.sun {
        return nil
    } else {
        return "Hate"
    }
}

getHaterStatus2(weather: WeatherType3.cloud)

// Dê uma olhada nas três primeiras linhas: a linha 1 dá um nome ao nosso tipo, WeatherType. Isso é o que você usará no lugar Stringou Intno seu código. A linha 2 define os cinco casos possíveis que nosso enum pode ser, como já descrevi. A convenção faz com que comecem com uma letra minúscula, então “sol”, “nuvem”, etc. E a linha 3 é apenas uma chave de fechamento, terminando a enumeração.
// Agora dê uma olhada em como ele é usado: eu modifiquei o getHaterStatus()para que ele receba um WeatherTypevalor. A instrução condicional também é reescrita para comparar com WeatherType.sun, que é nosso valor. Lembre-se, esta verificação é apenas um número nos bastidores, que é extremamente rápido.
// Agora, volte e leia esse código novamente, porque estou prestes a reescrevê-lo com duas mudanças que são importantes. Tudo pronto?

enum WeatherType4 {
    case sun
    case cloud
    case rain
    case wind
    case snow
}

func getHaterStatus3(weather: WeatherType4) -> String? {
    if weather == .sun {
        return nil
    } else {
        return "Hate"
    }
}

getHaterStatus3(weather: .cloud)

// Eu fiz duas diferenças lá. Primeiro, cada um dos tipos de clima está agora em sua própria linha. Isso pode parecer uma pequena mudança e, de fato, neste exemplo é, mas se torna importante em breve. A segunda mudança foi que eu escrevi if weather == .sun– não precisei explicar o que eu quis dizer WeatherType.sunporque Swift sabe que estou comparando com uma WeatherTypevariável, então está usando inferência de tipo.
// Enums são particularmente úteis dentro switch/casede blocos, principalmente porque o Swift conhece todos os valores que seu enum pode ter para garantir que você cubra todos eles. Por exemplo, podemos tentar reescrever o getHaterStatus()método para isso:

func getHaterStatus4(weather: WeatherType4) -> String? {
    switch weather {
    case .sun:
        return nil
    case .cloud, .wind:
        return "dislike"
    case .rain:
        return "hate"
    }
}

// Sim, eu sei que "haters vai não gostar" dificilmente é uma boa letra, mas é acadêmico de qualquer maneira porque esse código não vai construir: ele não lida com o .snowcaso, e Swift quer que todos os casos sejam cobertos. Você precisa adicionar um caso para ele ou adicionar um caso padrão.
// Enums com valores adicionais
// Um dos recursos mais poderosos do Swift é que as enumerações podem ter valores anexados a elas que você define. Para estender um pouco mais nosso exemplo cada vez mais duvidoso, vou adicionar um valor ao .windcaso para que possamos dizer o quão rápido é o vento. Modifique seu código para isso:

enum WeatherType5 {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}

// Como você pode ver, os outros casos não precisam de um valor de velocidade - eu coloquei isso apenas em wind. Agora, para a verdadeira mágica: Swift nos permite adicionar condições extras ao switch/casebloco para que um caso corresponda apenas se essas condições forem verdadeiras. Isso usa a letpalavra-chave para acessar o valor dentro de um caso e, em seguida, a palavra- wherechave para correspondência de padrões.

// Aqui está a nova função:

func getHaterStatus5(weather: WeatherType5) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "meh"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}

getHaterStatus5(weather: WeatherType5.wind(speed: 5))

// Você pode ver .windaparece lá duas vezes, mas a primeira vez só é verdade se o vento estiver mais lento do que 10 quilômetros por hora. Se o vento for 10 ou superior, isso não corresponderá. A chave é que você usa letpara obter o valor dentro da enumeração (ou seja, para declarar um nome constante que você pode referenciar) e usar uma wherecondição para verificar.
// O Swift avalia switch/casede cima para baixo e para assim que encontra uma correspondência. Isso significa que, se case .cloud, .wind:aparecer antes case .wind(let speed) where speed < 10:, será executado - e a saída será alterada.
// Então, pense com cuidado sobre como você encomenda casos!
// Dica: Os opcionais do Swift são implementados usando enums com valores associados. Existem dois casos: none, e some, com somequalquer valor que esteja dentro do opcional.

