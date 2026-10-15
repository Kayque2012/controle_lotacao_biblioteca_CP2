import 'package:controle_lotacao_biblioteca/models/ambiente.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Ambiente', () {
    test('nao permite entrada acima da capacidade maxima', () {
      final ambiente = Ambiente.biblioteca(capacidadeMaxima: 2);

      expect(ambiente.entrar(), isTrue);
      expect(ambiente.entrar(), isTrue);
      expect(ambiente.entrar(), isFalse);
      expect(ambiente.quantidadePessoas, 2);
      expect(ambiente.mensagemSituacao, 'Ambiente lotado');
    });

    test('nao permite saida abaixo de zero', () {
      final ambiente = Ambiente.biblioteca();

      expect(ambiente.sair(), isFalse);
      expect(ambiente.quantidadePessoas, 0);
    });

    test('exibe aviso de quase cheio a partir de 80 por cento', () {
      final ambiente = Ambiente.biblioteca(
        capacidadeMaxima: 10,
        quantidadeInicial: 8,
      );

      expect(ambiente.estaQuaseCheio, isTrue);
      expect(ambiente.mensagemSituacao, 'Atenção: ambiente quase cheio');
    });
  });
}
