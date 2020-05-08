import 'dart:io';

import 'f.dart';

int main(List<String> arguments) {

  if (arguments.length != 3) {
    stdout.write("Número inadequado de parâmetros!");
    return 1;
  }

  double sigma = double.tryParse(arguments[0]);
  double x = double.tryParse(arguments[1]);

  double ultimo_x = -double.maxFinite;
  int iteracoes = 0;


  double tempo_inicial = DateTime.now().microsecondsSinceEpoch/1000000;

  while (((x - ultimo_x)/(x)).abs() > sigma) {
    ++iteracoes;

    ultimo_x  = x;
    x = g(x);
  }

  double tempo_final = DateTime.now().microsecondsSinceEpoch/1000000;

  if(f(x).abs() > sigma) {
    print('Erro! Talvez a solução retornada seja inadequada\n');
  }

  stdout.write("Resultados finais: \n");
  stdout.write("\tMetodo: Ponto fixo\n");
  stdout.write("\tNúmero de iterações: ${iteracoes}\n");
  stdout.write("\tSolução aproximada: ${x}\n");
  stdout.write("\tTempo necessário: ${tempo_final - tempo_inicial}\n"); 
  return 0;
}