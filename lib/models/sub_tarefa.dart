class SubTarefa {
  final int id;
  final int tarefaId;
  final String titulo;
  final int feito;
  SubTarefa({this.id, this.tarefaId, this.titulo, this.feito});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'tarefaId': tarefaId,
      'titulo': titulo,
      'feito': feito,
    };
  }
}
