import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../models/pessoa.dart';

class PessoaItem extends StatelessWidget {
  final Pessoa pessoa;
  final VoidCallback onSaida;
  final VoidCallback onExcluir;

  const PessoaItem({super.key, required this.pessoa, required this.onSaida, required this.onExcluir});

  @override
  Widget build(BuildContext context) {
    final presente = pessoa.estaNoAmbiente;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Slidable(
        key: ValueKey('${pessoa.identificacao}-${pessoa.dataEntrada.microsecondsSinceEpoch}'),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(onPressed: (_) => onSaida(), backgroundColor: const Color(0xFFB36B25), foregroundColor: Colors.white, icon: Icons.logout, label: 'Saída'),
            SlidableAction(onPressed: (_) => onExcluir(), backgroundColor: const Color(0xFFB3261E), foregroundColor: Colors.white, icon: Icons.delete_outline, label: 'Excluir'),
          ],
        ),
        child: Card(
          color: Colors.white,
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(children: [
              const CircleAvatar(backgroundColor: Color(0xFFE9DED2), child: Icon(Icons.person_outline, color: Color(0xFF5B3A29))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(pessoa.nome, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Matrícula: ${pessoa.identificacao}'),
                Text('Entrada: ${DateFormat('dd/MM/yyyy HH:mm').format(pessoa.dataEntrada)}'),
                if (pessoa.dataSaida != null) Text('Saída: ${DateFormat('dd/MM/yyyy HH:mm').format(pessoa.dataSaida!)}'),
                Text(presente ? 'No ambiente' : 'Saiu', style: TextStyle(fontWeight: FontWeight.w600, color: presente ? const Color(0xFF217A46) : const Color(0xFF8D2D2D))),
              ])),
              const Icon(Icons.swipe_left, color: Color(0xFF88796F)),
            ]),
          ),
        ),
      ),
    );
  }
}
