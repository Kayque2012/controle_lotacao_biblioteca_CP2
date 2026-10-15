import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/ambiente.dart';
import '../models/pessoa.dart';
import '../widgets/pessoa_item.dart';

class ControleLotacaoPage extends StatefulWidget {
  const ControleLotacaoPage({super.key});
  @override
  State<ControleLotacaoPage> createState() => _ControleLotacaoPageState();
}

class _ControleLotacaoPageState extends State<ControleLotacaoPage> {
  final Ambiente _ambiente = Ambiente.biblioteca();
  final List<Pessoa> _pessoas = [];
  final _nomeController = TextEditingController();
  final _idController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _idController.dispose();
    super.dispose();
  }

  void _aviso(String texto) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(texto)));
  }

  void _cadastrar() {
    final nome = _nomeController.text.trim();
    final id = _idController.text.trim();
    if (nome.isEmpty || id.isEmpty) {
      _aviso('Preencha nome e matrícula.');
      return;
    }
    if (_pessoas.any((p) => p.identificacao.toLowerCase() == id.toLowerCase())) {
      _aviso('Já existe um registro com esta matrícula.');
      return;
    }
    if (_ambiente.estaLotado) {
      _aviso('Não é possível realizar a entrada. Ambiente lotado!');
      return;
    }
    setState(() {
      _ambiente.entrar();
      _pessoas.insert(0, Pessoa(nome: nome, identificacao: id, dataEntrada: DateTime.now()));
    });
    _nomeController.clear();
    _idController.clear();
    FocusScope.of(context).unfocus();
    _aviso('Pessoa cadastrada com sucesso!');
  }

  Future<bool> _confirmar(String titulo, String mensagem) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titulo),
        content: Text(mensagem),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('CANCELAR')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('CONFIRMAR')),
        ],
      ),
    ) ?? false;
  }

  Future<void> _saida(Pessoa pessoa) async {
    if (!pessoa.estaNoAmbiente) {
      _aviso('Esta pessoa já saiu do ambiente.');
      return;
    }
    final confirmou = await _confirmar('Registrar saída?', 'Deseja realmente registrar a saída de ${pessoa.nome}?');
    if (!mounted || !confirmou || !_pessoas.contains(pessoa) || !pessoa.estaNoAmbiente) return;
    setState(() {
      pessoa.dataSaida = DateTime.now();
      _ambiente.sair();
    });
    _aviso('Saída registrada com sucesso!');
  }

  Future<void> _excluir(Pessoa pessoa) async {
    final confirmou = await _confirmar('Excluir registro?', 'Deseja excluir o registro de ${pessoa.nome}?');
    if (!mounted || !confirmou || !_pessoas.contains(pessoa)) return;
    setState(() {
      if (pessoa.estaNoAmbiente) _ambiente.sair();
      _pessoas.remove(pessoa);
    });
    _aviso('Registro excluído com sucesso!');
  }

  Color get _corSituacao => _ambiente.estaLotado
      ? const Color(0xFFB3261E)
      : _ambiente.estaQuaseCheio ? const Color(0xFFE07800) : const Color(0xFF217A46);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_ambiente.nome, style: GoogleFonts.merriweather(fontWeight: FontWeight.bold)), centerTitle: true, backgroundColor: const Color(0xFF5B3A29), foregroundColor: Colors.white),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Expanded(child: ListView(children: [
              ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset('assets/images/biblioteca.png', height: 145, fit: BoxFit.cover)),
              const SizedBox(height: 14),
              Card(color: Colors.white, child: Padding(padding: const EdgeInsets.all(18), child: Column(children: [
                Text('Pessoas no ambiente', style: GoogleFonts.merriweather(fontSize: 17)),
                const SizedBox(height: 8),
                Text('${_ambiente.quantidadePessoas} / ${_ambiente.capacidadeMaxima}', style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color(0xFF5B3A29))),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: _ambiente.percentualOcupacao, minHeight: 10, color: _corSituacao, backgroundColor: const Color(0xFFE7DDD4)),
                const SizedBox(height: 8),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(_ambiente.estaLotado ? Icons.block : _ambiente.estaQuaseCheio ? Icons.warning_amber_rounded : Icons.check_circle_outline, color: _corSituacao), const SizedBox(width: 8), Text(_ambiente.mensagemSituacao, style: TextStyle(color: _corSituacao, fontWeight: FontWeight.bold))]),
              ]))),
              const SizedBox(height: 14),
              Text('Registrar entrada', style: GoogleFonts.merriweather(fontSize: 19, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(controller: _nomeController, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(labelText: 'Nome completo', prefixIcon: Icon(Icons.person_outline), border: OutlineInputBorder())),
              const SizedBox(height: 10),
              TextField(controller: _idController, decoration: const InputDecoration(labelText: 'Identificação / matrícula', prefixIcon: Icon(Icons.badge_outlined), border: OutlineInputBorder()), onSubmitted: (_) => _cadastrar()),
              const SizedBox(height: 10),
              SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: _cadastrar, icon: const Icon(Icons.person_add_alt_1), label: const Text('Registrar entrada'), style: FilledButton.styleFrom(backgroundColor: const Color(0xFF5B3A29), padding: const EdgeInsets.all(16)))),
              const SizedBox(height: 18),
              Row(children: [Expanded(child: Text('Registros (${_pessoas.length})', style: GoogleFonts.merriweather(fontSize: 19, fontWeight: FontWeight.bold))), const Icon(Icons.swipe_left), const SizedBox(width: 5), const Text('Deslize para ações', style: TextStyle(fontSize: 12))]),
              const SizedBox(height: 10),
              if (_pessoas.isEmpty) const Padding(padding: EdgeInsets.all(22), child: Center(child: Text('Nenhuma pessoa cadastrada.'))),
              ..._pessoas.map((p) => PessoaItem(pessoa: p, onSaida: () => _saida(p), onExcluir: () => _excluir(p))),
            ])),
          ]),
        ),
      ),
    );
  }
}
