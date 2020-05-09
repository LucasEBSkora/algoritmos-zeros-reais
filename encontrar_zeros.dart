

import 'dart:io';

int main (List<String> arguments) {


  if (arguments.length < 3 || arguments.length > 5) {
    print("");
    print("Uso: dart encontrar_zeros.dart metodo f sigma args");
    print("Onde metodo é o método a ser usado, f é a função à analisar,sigma é a precisão desejada, e args são argumentos extras necessários de acordo com o algoritmo");
    print("Para usar espaços com a função, a envolva com aspas");
    print("Opções para metodo:\n\tbisseccao: Bissecção - args: a b, que são os limites do intervalo fechado onde buscar as raízes\n");
    print("\tsecantes: Método da Posição Falsa, Cordas ou Secantes - args: a b, que são os limites do intervalo fechado onde buscar as raízes\n");
    print("\tponto_fixo: Método do ponto fixo - args: x0 g, onde x0 é uma aproximação inicial e g é a função de ponto fixo à usar.");
    print("\ttangentes: Método de Newton/das tangentes -args: x0, onde x0 é uma aproximação inicial");

    print('Exemplos:\n\tdart encontrar_zeros.dart bisseccao "pow(x,x) - 2" 0.01');
    print('\tdart encontrar_zeros.dart secantes "pow(2, x) - pow(x, 2)" 0.0005 1 10');
    print('\tdart encontrar_zeros.dart ponto_fixo "pow(2,x) - x - 2" 0.001 1 "pow(x,2) - 2"');
    print("");
    return -1;
  }

  String metodo = arguments[0];
  String f = arguments[1];

  File arquivoModelo = File('_f.dart');
  String conteudosArquivo = arquivoModelo.readAsStringSync();
  conteudosArquivo = conteudosArquivo.replaceAll('~', f);
  
  if(metodo == "ponto_fixo") {
    conteudosArquivo = conteudosArquivo.replaceAll('0', arguments[4]);
  }
  
  File arquivoFinal = File('f.dart');
  arquivoFinal.writeAsStringSync(conteudosArquivo);
  arquivoFinal.createSync();

  
  Process.run('dart', ["${metodo}.dart", ...arguments.sublist(2)] ).then((ProcessResult r) {
    print(r.stdout);
    return r.exitCode; 
  });

  return 0;
}