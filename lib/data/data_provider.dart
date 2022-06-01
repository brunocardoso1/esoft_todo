import 'package:esoft_todo/models/sub_tarefa.dart';
import 'package:esoft_todo/models/tarefa.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataProvider {
  Future<Database> database() async{
    return openDatabase(
      join(await getDatabasesPath(), 'tarefa.db'),
      onCreate: (db, version)async{
        await db.execute(
          "CREATE TABLE tarefas(id INTEGER PRIMARY KEY, titulo TEXT, descricao TEXT)"
        );
        await db.execute(
            "CREATE TABLE subtarefas(id INTEGER PRIMARY KEY, tarefaId INTEGER, titulo TEXT, feito INTEGER)"
        );
        return db;
      },
      version: 1,
    );
  }

  Future<int> insertTask(Tarefa tarefa) async{

    int tarefaId = 0;
    Database _db = await database();
    await _db.insert('tarefas', tarefa.toMap()).then((value){
      tarefaId = value;
    });
    return tarefaId;
  }

  Future<void> insertSubTask(SubTarefa subTarefa) async{
    Database _db = await database();
    await _db.insert('subtarefas', subTarefa.toMap());
  }

  Future<List<Tarefa>> getTarefa() async {
    Database _db = await database();
    List<Map<String, dynamic>> mapTarefa = await _db.query('tarefas');
    return List.generate(mapTarefa.length, (index){
      mapTarefa.length;
      return Tarefa(
        id: mapTarefa[index]['id'], titulo: mapTarefa[index]['titulo'], descricao: mapTarefa[index]['descricao']
      );
    });
  }

  Future<List<SubTarefa>> getSubTarefa(int tarefaId) async {
    Database _db = await database();
    List<Map<String, dynamic>> mapSubTarefa = await _db.rawQuery('SELECT * FROM subtarefas WHERE tarefaId = $tarefaId');
    return List.generate(mapSubTarefa.length, (index){
      mapSubTarefa.length;
      return SubTarefa(
          id: mapSubTarefa[index]['id'], titulo: mapSubTarefa[index]['titulo'],
          tarefaId: mapSubTarefa[index]['tarefaId'], feito: mapSubTarefa[index]['feito']
      );
    });
  }

  Future<void> updateTitulo(int id, String titulo) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tarefas SET titulo = '$titulo' WHERE id = '$id'");
  }

  Future<void> updateDescricao(int id, String descricao) async {
    Database _db = await database();
    await _db.rawUpdate(
        "UPDATE tarefas SET descricao = '$descricao' WHERE id = '$id'");
  }

  Future<void> updateFeito(int id, int feito) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE subtarefas SET feito = '$feito' WHERE id = '$id'");
  }

  Future<void> deleteTarefa(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM tarefas WHERE id = '$id'");
    await _db.rawDelete("DELETE FROM subtarefas WHERE tarefaId = '$id'");
  }

}