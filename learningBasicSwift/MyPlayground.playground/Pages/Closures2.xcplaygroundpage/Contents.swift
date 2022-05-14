//: [Previous](@previous)

import Foundation
import UIKit

/*
Você conheceu inteiros, strings, doubles, floats, Booleans, arrays, dicionários, structs e classes até agora, mas há outro tipo de dados que é usado extensivamente no Swift, e é chamado de closure. Elas são complicadas, mas são tão poderosas e expressivas que são usadas amplamente no Cocoa Touch, então você não irá muito longe sem entendê-las.

Um encerramento pode ser pensado como uma variável que contém código. Assim, onde um inteiro contém 0 ou 500, um encerramento contém linhas de código Swift. Os fechamentos também capturam o ambiente onde são criados, o que significa que eles fazem uma cópia dos valores que são usados ​​dentro deles.

Você nunca precisa projetar seus próprios fechamentos, portanto, não tenha medo se achar o seguinte bastante complicado. No entanto, tanto o Cocoa quanto o Cocoa Touch geralmente pedem que você escreva fechamentos para atender às necessidades deles, então você precisa pelo menos saber como eles funcionam. Vamos dar um exemplo do Cocoa Touch primeiro:
*/

let vw = UIView()

UIView.animate(withDuration: 0.5, animations: {
    vw.alpha = 0
})

/*
UIView é um tipo de dados iOS no UIKit que representa o tipo mais básico de contêiner de interface do usuário. Não se preocupe com o que ele faz por enquanto, tudo o que importa é que é o componente básico da interface do usuário. UIViewtem um método chamado animate()e permite que você altere a aparência de sua interface usando animação – você descreve o que está mudando e em quantos segundos, e o Cocoa Touch faz o resto.

O animate() método usa dois parâmetros nesse código: o número de segundos para animar e um encerramento contendo o código a ser executado como parte da animação. Eu especifiquei meio segundo como o primeiro parâmetro e, para o segundo, pedi ao UIKit para ajustar o alfa da exibição (opacidade) para 0, o que significa "completamente transparente".

Este método precisa usar um closure porque o UIKit tem que fazer todo tipo de trabalho para se preparar para o início da animação, então o que acontece é que o UIKit pega uma cópia do código dentro das chaves (esse é o nosso closure), armazena-o, faz todo o seu trabalho de preparação e, em seguida, executa nosso código quando estiver pronto. Isso não seria possível se apenas executássemos nosso código diretamente.

O código acima também mostra como as closures capturam seu ambiente: eu declarei a vwconstante fora da closure, então a usei dentro. O Swift detecta isso e disponibiliza esses dados dentro do fechamento também.

O sistema do Swift de capturar automaticamente o ambiente de uma closure é muito útil, mas ocasionalmente pode te atrapalhar: se o objeto A armazena uma closure como uma propriedade, e essa propriedade também referencia o objeto A, você tem algo chamado ciclo de referência forte e terá usuários insatisfeitos. Este é um tópico substancialmente mais avançado do que você precisa saber agora, então não se preocupe muito com isso ainda.

Fechamentos à direita
Como os closures são usados ​​com tanta frequência, o Swift pode aplicar um pouco de açúcar sintático para tornar seu código mais fácil de ler. A regra é esta: se o último parâmetro de um método tiver um encerramento, você pode eliminar esse parâmetro e, em vez disso, fornecê-lo como um bloco de código dentro de chaves. Por exemplo, poderíamos converter o código anterior para isso:
*/

let vw2 = UIView()

UIView.animate(withDuration: 0.5) {
    vw2.alpha = 0
}

/*
Isso torna seu código mais curto e mais fácil de ler, portanto, essa forma de sintaxe – conhecida como sintaxe de fechamento à direita – é a preferida.
*/
