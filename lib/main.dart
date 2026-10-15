import 'package:flutter/material.dart';

import 'pages/controle_lotacao_page.dart';

void main() {
  runApp(const ControleLotacaoApp());
}

class ControleLotacaoApp extends StatelessWidget {
  const ControleLotacaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biblioteca FIAP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B3A29),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5EFE7),
        useMaterial3: true,
      ),
      home: const ControleLotacaoPage(),
    );
  }
}
