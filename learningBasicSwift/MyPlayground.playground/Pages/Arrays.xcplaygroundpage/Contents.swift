//: [Previous](@previous)

import Foundation

// As matrizes permitem agrupar muitos valores em uma única coleção e, em seguida, acessar esses valores por sua posição na coleção. Swift usa inferência de tipo para descobrir que tipo de dados seu array contém, assim:

var evenNumbers = [2, 4, 6, 8]
var songs = ["Shake it Off", "You Belong with Me", "Back to December"]

//Como você pode ver, o Swift usa colchetes para marcar o início e o fim de um array, e cada item do array é separado por uma vírgula.
// Quando se trata de ler itens de uma matriz, há um problema: Swift começa a contar em 0. Isso significa que o primeiro item é 0, o segundo item é 1, o terceiro é 2 e assim por diante. Tente colocar isso em seu playground:

var songs2 = ["Shake it Off", "You Belong with Me", "Back to December"]
songs2[0]
songs2[1]
songs2[2]

// Isso imprimirá "Shake it Off", "You Belong with Me" e "Back to December" no painel de resultados.
// A posição de um item em uma matriz é chamada de índice, e você pode ler qualquer item da matriz apenas fornecendo seu índice. No entanto, você precisa ter cuidado: nosso array tem três itens, o que significa que os índices 0, 1 e 2 funcionam muito bem. Mas se você tentar ler songs[3], seu playground parará de funcionar - e se você tentar isso em um aplicativo real, ele travará!
// Como você criou seu array fornecendo três strings, o Swift sabe que este é um array de strings. Você pode confirmar isso usando um comando especial no playground que imprimirá o tipo de dados de qualquer variável, assim:

var songs3 = ["Shake it Off", "You Belong with Me", "Back to December"]
type(of: songs3)

// Isso será impresso Array<String>.Typeno painel de resultados, informando que o Swift considera songsuma matriz de strings.
// Digamos que você cometeu um erro e acidentalmente colocou um número no final da matriz. Tente isso agora e veja o que o painel de resultados imprime:

var songs4 = ["Shake it Off", "You Belong with Me", "Back to December", 3]
type(of: songs4)

// Desta vez, você verá um erro. O erro não é porque o Swift não pode lidar com arrays mistos como este – mostrarei como fazer isso em breve! – mas sim porque o Swift está sendo útil. A mensagem de erro que você verá é: “literal de coleção heterogêneo só pode ser inferido para '[Qualquer]'; adicione anotação de tipo explícita se isso for intencional.” Ou, em inglês simples, “parece que esse array foi projetado para armazenar muitos tipos de dados – se você realmente quis dizer isso, por favor, deixe-o explícito”.
// A segurança de tipo é importante e, embora seja legal que o Swift possa fazer com que os arrays contenham qualquer tipo de dado, esse caso em particular foi um acidente. Felizmente, eu já disse que você pode usar anotações de tipo para especificar exatamente que tipo de dados você deseja que um array armazene. Para especificar o tipo de uma matriz, escreva o tipo de dados que deseja armazenar entre colchetes, assim:

var songs5: [String] = ["Shake it Off", "You Belong with Me", "Back to December", 3]

// Agora que dissemos ao Swift que queremos armazenar apenas strings no array, ele sempre se recusará a executar o código porque 3 não é uma string.
// Se você realmente deseja que o array contenha qualquer tipo de dado, use o Anytipo de dado especial, como este:

var songs6: [Any] = ["Shake it Off", "You Belong with Me", "Back to December", 3]

// Criando matrizes
// Se você criar um array usando a sintaxe mostrada acima, o Swift cria o array e o preenche com os valores que especificamos. As coisas não são tão simples se você quiser criar o array e preenchê-lo mais tarde – esta sintaxe não funciona:

var songs7: [String]
songs7[0] = "Shake it Off"

// A razão é uma que parecerá desnecessariamente pedante no início, mas tem profundas implicações de desempenho subjacentes, então temo que você esteja apenas preso a ela. Simplificando, escrever var songs: [String]diz ao Swift que "a songsvariável conterá um array de strings", mas na verdade não cria esse array . Ele não aloca nenhuma RAM ou faz nenhum trabalho para realmente criar um array Swift. Ele apenas diz que em algum momento haverá uma matriz e conterá strings.
// Existem algumas maneiras de expressar isso corretamente, e a que provavelmente faz mais sentido neste momento é esta:

var songs8: [String] = []

// Isso usa uma anotação de tipo para deixar claro que queremos uma matriz de strings e atribui uma matriz vazia (essa é a []parte) a ela.
// Você também verá comumente esta construção:

var songs9 = [String]()

// Isso significa a mesma coisa: ()diz ao Swift que queremos criar o array em questão, que é então atribuído ao songsuso de inferência de tipo. Esta opção é dois caracteres mais curta, então não é surpresa que os programadores a prefiram!
// Operadores de matriz
// Você pode usar um conjunto limitado de operadores em matrizes. Por exemplo, você pode mesclar dois arrays usando o operador +, assim:

var songs10 = ["Shake it Off", "You Belong with Me", "Love Story"]
var songs11 = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]
var both = songs + songs2

// Você também pode usar += para adicionar e atribuir, assim:

both += ["Everything has Changed"]
