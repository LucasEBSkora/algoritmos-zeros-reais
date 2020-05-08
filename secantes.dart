import 'dart:io';

import 'f.dart' show f;
/*
  Essencialmente igual ao método da bissecção, mas usa a média ponderada com os valores de f(ak) e f(bk) pra determinar x(k+1)
  x = a*|f(b)|+b|f(a)|/(|f(b)|+|f(a)|)
*/
int main(List<String> arguments) {

  const double valorMinimoViavel = -1e6;
  const double valorMaximoViavel = 1e6;

  double a;
  double b;
  double sigma;

  if (arguments.length == 1) {
    
    sigma = double.tryParse(arguments[0]);
    
    stdout.write("Nenhuma dica de intervalo foi passada! testando em [${valorMinimoViavel}, ${valorMaximoViavel}]...\n\n");
    
    if (f(double.negativeInfinity)*f(double.infinity) < 0) {
    
      stdout.write("\tIntervalo válido! os testes começaram entre [${valorMinimoViavel}, ${valorMaximoViavel}]\n");
      a = valorMinimoViavel;
      b = valorMaximoViavel;
    
    } else {
    
      stdout.write("\tIntervalo inválido! Continuando...\n\n");
      stdout.write("testando [-${valorMaximoViavel}, 0]...\n");
    
      if (f(valorMinimoViavel)*f(0) < 0) {
    
        stdout.write("\tIntervalo válido! os testes começaram entre [${valorMaximoViavel}, 0]\n");
        a = valorMinimoViavel;
        b = 0.0;
    
      } else {
    
        stdout.write("\tIntervalo inválido! Continuando...\n\n");
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



    //Única mudança real em relação ao método da bissecção
    x = ((f(a).abs()*a)+(f(b).abs()*b))/(f(a).abs() + f(b).abs());
    //x = (a+b)/2;

    if (f(a)*f(x) < 0) {
      b = x;
    } else if (f(x)*f(b) < 0) {
      a = x;
    }
    
    if (x == ultimo_x) {
      stdout.write("Intervalo inválido! Por favor, forneça um intervalo mais adequado.\n");
      return 1;
    }

    ++iteracoes;

  } while (((x - ultimo_x)/x).abs() > sigma || f(x).abs() > sigma);



  double tempo_final = DateTime.now().microsecondsSinceEpoch/1000000;

  if(f(x).abs() > sigma) {
    print('Erro! Talvez a solução retornada seja inadequada\n');
  }

  stdout.write("Resultados finais: \n");
  stdout.write("\tMetodo: Secantes\n");
  stdout.write("\tNúmero de iterações: ${iteracoes}\n");
  stdout.write("\tIntervalo contendo respostas exata: [${a}, ${b}]\n");
  stdout.write("\tSolução aproximada: ${x}\n");
  stdout.write("\tTempo necessário: ${tempo_final - tempo_inicial}\n");
  return 0;
}