//: [Previous](@previous)

import Foundation

// Como você viu, os arrays Swift são uma coleção onde você acessa cada item usando um índice numérico, como songs[0]. Os dicionários são outro tipo comum de coleção, mas diferem dos arrays porque permitem acessar valores com base em uma chave especificada.

// Para dar um exemplo, vamos imaginar como podemos armazenar dados sobre uma pessoa em um array:

var person = ["Taylor", "Alison", "Swift", "December", "taylorswift.com"]

// Para ler o nome do meio dessa pessoa, usamos person[1], e para ler o mês em que ela nasceu, usamos person[3]. Isso tem alguns problemas, principalmente porque é difícil lembrar qual número de índice é atribuído a cada valor na matriz! E o que acontece se a pessoa não tiver nome do meio? As chances são de que todos os outros valores desçam uma posição, causando caos em seu código.

// Com dicionários, podemos reescrever isso para ser muito mais sensato, porque, em vez de números arbitrários, você lê e escreve valores usando uma chave que você especifica. Por exemplo:

var person2 = ["first": "Taylor", "middle": "Alison", "last": "Swift", "month": "December", "website": "taylorswift.com"]
person2["middle"]
person2["month"]

// Pode ajudar se eu usar muitos espaços em branco para dividir o dicionário na tela, assim:

var person3 = [
                "first": "Taylor",
                "middle": "Alison",
                "last": "Swift",
                "month": "December",
                "website": "taylorswift.com"
            ]

person3["middle"]
person3["month"]

// Como você pode ver, quando você faz um dicionário, você escreve sua chave, depois dois pontos e depois seu valor. Você pode ler qualquer valor do dicionário apenas conhecendo sua chave, o que é muito mais fácil de trabalhar.
// Tal como acontece com os arrays, você pode armazenar uma grande variedade de valores dentro de dicionários, embora as chaves sejam mais comumente strings.
