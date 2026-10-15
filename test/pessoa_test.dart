import 'package:flutter_test/flutter_test.dart';
import 'package:controle_lotacao_biblioteca/models/pessoa.dart';
void main() {
  test('registra mudanca de situacao na saida', () {
    final pessoa = Pessoa(nome: 'Ana', identificacao: '1', dataEntrada: DateTime(2026, 10, 14));
    expect(pessoa.estaNoAmbiente, isTrue);
    pessoa.dataSaida = DateTime(2026, 10, 14, 12);
    expect(pessoa.estaNoAmbiente, isFalse);
  });
}
