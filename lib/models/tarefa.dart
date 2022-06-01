class Tarefa {
  final int id;
  final String titulo;
  final String descricao;

  Tarefa({this.id, this.titulo, this.descricao});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
    };
  }
}
