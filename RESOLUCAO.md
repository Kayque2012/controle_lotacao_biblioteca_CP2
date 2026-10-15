# Resolução do Checkpoint 01

## Ambiente escolhido

Biblioteca, com capacidade máxima de 50 pessoas.

## Regras implementadas

1. O botão `Entrou` chama o método `entrar()`. Quando o contador chega a 50, o método retorna `false` e não altera o valor.
2. O botão `Saiu` chama o método `sair()`. Quando o contador está em zero, o método retorna `false` e não altera o valor.
3. O getter `mensagemSituacao` retorna:
   - `Pode entrar` de 0 a 39 pessoas;
   - `Atenção: ambiente quase cheio` de 40 a 49 pessoas;
   - `Ambiente lotado` com 50 pessoas.
4. O setter `quantidadePessoas` aceita apenas valores entre zero e a capacidade máxima.

## Componentes obrigatórios

- `Scaffold`: estrutura da tela.
- `Container`: cartões, imagem e caixa de situação.
- `Column`: organização vertical.
- `Row`: botões e conteúdo do aviso.
- `Text`: títulos, contador, capacidade e situação.
- `TextButton`: ações de entrada e saída.
- `TextButton.styleFrom`: personalização dos dois botões.
- Asset: `assets/images/biblioteca.png`.

## Desafio extra

A classe `Ambiente`, em `lib/models/ambiente.dart`, contém atributos, o construtor nomeado `Ambiente.biblioteca`, getters, setter e os métodos `entrar()` e `sair()`.
