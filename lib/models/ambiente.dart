class Ambiente {
  final String nome;
  final int capacidadeMaxima;
  int _quantidadePessoas;

  // Construtor nomeado solicitado no desafio extra.
  Ambiente.biblioteca({
    this.nome = 'Biblioteca FIAP',
    this.capacidadeMaxima = 50,
    int quantidadeInicial = 0,
  }) : _quantidadePessoas = quantidadeInicial;

  // Getter da quantidade atual.
  int get quantidadePessoas => _quantidadePessoas;

  // Setter protege o estado contra valores invalidos.
  set quantidadePessoas(int valor) {
    if (valor >= 0 && valor <= capacidadeMaxima) {
      _quantidadePessoas = valor;
    }
  }

  bool get estaLotado => _quantidadePessoas == capacidadeMaxima;

  // A partir de 80% da capacidade, o ambiente fica quase cheio.
  bool get estaQuaseCheio =>
      !estaLotado && _quantidadePessoas >= capacidadeMaxima * 0.8;

  String get mensagemSituacao {
    if (estaLotado) {
      return 'Ambiente lotado';
    }
    if (estaQuaseCheio) {
      return 'Atenção: ambiente quase cheio';
    }
    return 'Pode entrar';
  }

  double get percentualOcupacao => _quantidadePessoas / capacidadeMaxima;

  // Métodos de entrada e saída solicitados pelo aplicativo.
  bool entrar() {
    if (estaLotado) {
      return false;
    }
    quantidadePessoas = _quantidadePessoas + 1;
    return true;
  }

  bool sair() {
    if (_quantidadePessoas == 0) {
      return false;
    }
    quantidadePessoas = _quantidadePessoas - 1;
    return true;
  }
}
