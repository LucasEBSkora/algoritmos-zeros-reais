import 'dart:io';

import 'f.dart' show f;
/*
Esse método consiste em encontrar, a partir do intervalo inicial,
intervalos com métade da amplitude do anterior contendo a raiz até que
a medida desse intervalo esteja dentro da precisão desejada ((b - a) < sigma)

passos:
  1. determinar intervalo inicial [a0,b0] tal que f(a0)*f(b0) < 0
  (Pois se a função for contínua, pelo teorema do valor médio, isso é suficiente para garantir que a função tem uma raiz no intervalo)

  2. calcular o ponto médio do intervalo xk = (ak+bk)/2

  3. Se |xk - x(k-1)|/|xk| < sigma ou |f(xk)| < sigma, já estamos na precisão desejada, e podemos parar o algoritmo.

  4. Do contrário, determinamos se a raiz está no lado esquerdo ou direito do intervalo.
    4.1 Se f(ak)*f(xk) < 0, a raiz está no lado esquerdo do intervalo, e a(k+1) = ak e b(k+1) = xk
    4.2 Se f(xk)*f(bk) < 0, a raiz está no lado direito do intervalo, e a(k+1) = xk e b(k+1) = bk

  No final, temos um intervalo que contém a raiz exata [a, b] e uma aproximação x para a raiz.


  Esse método sempre converge se a função for contínua e existir uma raiz no intervalo, mas pode ser muito devagar se
  (b0 - a0) >>> sigma e se sigma for muito pequeno.
*/
int main(List<String> arguments) {

  const double valorMinimoViavel = -double.maxFinite;
  const double valorMaximoViavel = double.maxFinite;

  double a;
  double b;
  double sigma;

  if (arguments.length == 1) {
    
    sigma = double.tryParse(arguments[0]);
    
    stdout.write("Nenhuma dica de intervalo foi passada! testando em [${valorMinimoViavel}, ${valorMaximoViavel}]...\n");
    
    if (f(double.negativeInfinity)*f(double.infinity) < 0) {
    
      stdout.write("\tIntervalo válido! os testes começaram entre [${valorMinimoViavel}, ${valorMaximoViavel}]\n");
      a = valorMinimoViavel;
      b = valorMaximoViavel;
    
    } else {
    
      stdout.write("\tIntervalo inválido! Continuando...\n");
      stdout.write("testando [-${valorMaximoViavel}, 0]...\n");
    
      if (f(valorMinimoViavel)*f(0) < 0) {
    
        stdout.write("\tIntervalo válido! os testes começaram entre [${valorMaximoViavel}, 0]\n");
        a = valorMinimoViavel;
        b = 0.0;
    
      } else {
    
        stdout.write("\tIntervalo inválido! COntinuando...\n");
        stdout.write("testando [0, ${valorMaximoViavel}]\n");
    
        if (f(0)*f(valorMaximoViavel) < 0) {
          stdout.write("\tIntervalo válido! Os testes começaram entre [0, ${valorMaximoViavel}]\n");
          a = 0.0;
          b = valorMaximoViavel;
        } else {
          stdout.write("Valores iniciais padrão não aplicáveis! por favor, forneça valores para o intervalo inicial.\n");
          return 1;
        }
      }
    } 
  } else {
    
    sigma = double.tryParse(arguments[0]); 
    if (sigma == null) {
      stdout.write("Erro! valor do parâmetro 'sigma' não é um número real!\n");
      return 1;
    }

    a = double.tryParse(arguments[1]); 
    if (a == null) {
      stdout.write("Erro! valor do parâmetro 'a' não é um número real!\n");
      return 1;
    }
    
    b = double.tryParse(arguments[2]); 
    if (b == null) {
      stdout.write("Erro! valor do parâmetro 'b' não é um número real!\n");
      return 1;
    }
    
    if (f(a)*f(b) > 0) {
      stdout.write("\nAtenção! Não é garantido que há uma raiz dessa função nesse intervalo! (f(a)*f(b) > 0)\n");
      stdout.write("\nVerifique os resultados antes de usá-los!\n");
    }


  }

  double x = double.maxFinite;
  double ultimo_x;

  int iteracoes = 0;

  double tempo_inicial = DateTime.now().microsecondsSinceEpoch/1000000; 

  do {
    ultimo_x = x;
    x = (a+b)/2;

    if (f(a)*f(x) < 0) {
      b = x;
    } else if (f(x)*f(b) < 0) {
      a = x;
    }
    
    ++iteracoes;

  } while (((x - ultimo_x)/x).abs() > sigma && f(x).abs() > sigma);

  double tempo_final = DateTime.now().microsecondsSinceEpoch/1000000;
  
  stdout.write("Resultados finais: \n");
  stdout.write("\tMetodo: Bissecção\n");
  stdout.write("\tNúmero de iterações: ${iteracoes}\n");
  stdout.write("\tIntervalo contendo respostas exata: [${a}, ${b}]\n");
  stdout.write("\tSolução aproximada: ${x}\n");
  stdout.write("\tTempo necessário: ${tempo_final - tempo_inicial}\n");
  return 0;
}