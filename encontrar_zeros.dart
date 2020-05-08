

import 'dart:io';

int main (List<String> arguments) {


  if (arguments.length < 3 || arguments.length > 5) {
    print("");
    print("Uso: dart encontrar_zeros.dart metodo f sigma a b");
    print("Onde metodo é o método a ser usado, f é a função à analisar,sigma é a precisão desejada, e a e b são os limites do intervalo onde se deve procurar zeros (opcional)");
    print("Para usar espaços com a função, a envolva com aspas");
    print("Opções para metodo:\n\tbisseccao: Bissecção\n");
    print("\tsecantes: Método da Posição Falsa, Cordas ou Secantes\n");

    print('Exemplo:\n\tdart encontrar_zeros.dart bisseccao "pow(x,x) - 2" 0.01');
    print('\tdart encontrar_zeros.dart secantes "pow(2, x) - pow(x, 2)" 0.0005 1 10');
    print("");
    return -1;
  }

  String metodo = arguments[0];
  String f = arguments[1];

  File arquivoModelo = File('_f.dart');
  String conteudosArquivo = arquivoModelo.readAsStringSync();
  conteudosArquivo = conteudosArquivo.replaceAll('~', f);
  
  
  File arquivoFinal = File('f.dart');
  arquivoFinal.writeAsStringSync(conteudosArquivo);
  arquivoFinal.createSync();

  
  Process.run('dart', ["${metodo}.dart", ...arguments.sublist(2)] ).then((ProcessResult r) {
    print(r.stdout);
    return r.exitCode; 
  });

  return 0;
}