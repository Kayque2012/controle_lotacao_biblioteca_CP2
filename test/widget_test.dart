import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:controle_lotacao_biblioteca/main.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  Future<void> localizar(WidgetTester tester, Finder alvo) async {
    if (alvo.evaluate().isEmpty) {
      await tester.scrollUntilVisible(
        alvo,
        160,
        scrollable: find.byType(Scrollable).first,
      );
    } else {
      await tester.ensureVisible(alvo.first);
    }
    await tester.pump();
  }

  Future<void> cadastrar(WidgetTester tester, String nome, String matricula) async {
    await localizar(tester, find.byType(TextField).first);
    await tester.enterText(find.byType(TextField).at(0), nome);
    await tester.enterText(find.byType(TextField).at(1), matricula);
    await localizar(tester, find.widgetWithText(FilledButton, 'Registrar entrada'));
    await tester.tap(find.widgetWithText(FilledButton, 'Registrar entrada'));
    await tester.pumpAndSettle();
  }

  testWidgets('mostra lotacao e campos de cadastro', (tester) async {
    await tester.pumpWidget(const ControleLotacaoApp());
    expect(find.text('0 / 50'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    await localizar(tester, find.text('Nenhuma pessoa cadastrada.'));
    expect(find.text('Nenhuma pessoa cadastrada.'), findsOneWidget);
  });

  testWidgets('cadastra pessoa e atualiza lotacao', (tester) async {
    await tester.pumpWidget(const ControleLotacaoApp());
    await cadastrar(tester, 'Maria Silva', '123456');
    await localizar(tester, find.text('Maria Silva'));
    expect(find.text('Maria Silva'), findsOneWidget);
    expect(find.text('Matrícula: 123456'), findsOneWidget);
    await localizar(tester, find.text('1 / 50'));
    expect(find.text('1 / 50'), findsOneWidget);
  });

  testWidgets('bloqueia campos vazios', (tester) async {
    await tester.pumpWidget(const ControleLotacaoApp());
    await localizar(tester, find.widgetWithText(FilledButton, 'Registrar entrada'));
    await tester.tap(find.widgetWithText(FilledButton, 'Registrar entrada'));
    await tester.pump();
    expect(find.text('Preencha nome e matrícula.'), findsOneWidget);
    await localizar(tester, find.text('0 / 50'));
    expect(find.text('0 / 50'), findsOneWidget);
  });

  testWidgets('bloqueia matricula duplicada', (tester) async {
    await tester.pumpWidget(const ControleLotacaoApp());
    await cadastrar(tester, 'Maria', '123');
    await cadastrar(tester, 'João', '123');
    expect(find.text('Já existe um registro com esta matrícula.'), findsOneWidget);
    await localizar(tester, find.text('1 / 50'));
    expect(find.text('1 / 50'), findsOneWidget);
  });
}
