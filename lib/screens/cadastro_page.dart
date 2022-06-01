import 'package:esoft_todo/data/data_provider.dart';
import 'package:esoft_todo/models/sub_tarefa.dart';
import 'package:esoft_todo/models/tarefa.dart';
import 'package:esoft_todo/utilidades/colors.dart';
import 'package:esoft_todo/widgets/checklist.dart';
import 'package:flutter/material.dart';

class CadastrarTODO extends StatefulWidget {
  final Tarefa tarefa;

  CadastrarTODO({@required this.tarefa});

  @override
  _CadastrarTODOState createState() => _CadastrarTODOState();
}

class _CadastrarTODOState extends State<CadastrarTODO> {
  int _tarefaId = 0;
  String _tituloTarefa = "";
  String _descricaoTarefa = "";
  DataProvider _dbprovide = DataProvider();

  bool _visivelController = false;

  @override
  void initState() {
    if (widget.tarefa != null) {
      _visivelController = true;
      _tituloTarefa = widget.tarefa.titulo;
      _descricaoTarefa = widget.tarefa.descricao;
      _tarefaId = widget.tarefa.id;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: roxo,
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            maxLength: 25,
                            onSubmitted: (value) async {
                              print(value);
                              if (value != "") {
                                if (widget.tarefa == null) {
                                  Tarefa _novaTarefa = Tarefa(
                                    titulo: value,
                                  );
                                  _tarefaId =
                                      await _dbprovide.insertTask(_novaTarefa);
                                  print("Nova tarefa: $_tarefaId");
                                  setState(() {
                                    _visivelController = true;
                                    _tituloTarefa = value;
                                  });
                                } else {
                                  await _dbprovide.updateTitulo(
                                      _tarefaId, value);
                                  print("Tarefa atualizada");
                                }
                              }
                            },
                            style: TextStyle(fontSize: 24),
                            controller: TextEditingController()
                              ..text = _tituloTarefa,
                            decoration: InputDecoration(
                              hintText: "Adicionar Titulo",
                              //border: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                    Visibility(
                      visible: _visivelController,
                      child: TextField(
                        maxLength: 35,
                        onSubmitted: (value) async {
                          if (value != "") {
                            if (_tarefaId != 0) {
                              await _dbprovide.updateDescricao(
                                  _tarefaId, value);
                              _descricaoTarefa = value;
                            } else {
                              print("Update executado");
                            }
                          }
                        },
                        controller: TextEditingController()
                          ..text = _descricaoTarefa,
                        decoration: InputDecoration(
                          hintText: "Adicione uma descrição para a tarefa",
                          //border: InputBorder.none,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _visivelController,
                      child: FutureBuilder(
                        initialData: [],
                        future: _dbprovide.getSubTarefa(_tarefaId),
                        builder: (context, snapshot) {
                          return Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      if (snapshot.data[index].feito == 0) {
                                        await _dbprovide.updateFeito(
                                            snapshot.data[index].id, 1);
                                      } else {
                                        await _dbprovide.updateFeito(
                                            snapshot.data[index].id, 0);
                                      }
                                      setState(() {});
                                    },
                                    child: CheckList(
                                      texto: snapshot.data[index].titulo,
                                      feito: snapshot.data[index].feito == 0
                                          ? false
                                          : true,
                                    ),
                                  );
                                }),
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible: _visivelController,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: Colors.grey, width: 2)),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 25),
                                  child: TextField(
                                    controller: TextEditingController()
                                      ..text = "",
                                    onSubmitted: (value) async {
                                      if (value != "") {
                                        if (_tarefaId != 0) {
                                          DataProvider _dbprovide =
                                              DataProvider();
                                          SubTarefa _novaSubTarefa = SubTarefa(
                                            titulo: value,
                                            feito: 0,
                                            tarefaId: _tarefaId,
                                          );
                                          await _dbprovide
                                              .insertSubTask(_novaSubTarefa);
                                          setState(() {});
                                        }
                                        print("Sub-Tarefa criada");
                                      }
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Adicionar itens para tarefa",
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: _visivelController,
                  child: Positioned(
                      bottom: 20,
                      right: 0,
                      child: FloatingActionButton(
                        onPressed: () async {
                          if (_tarefaId != 0) {
                            await _dbprovide.deleteTarefa(_tarefaId);
                            Navigator.pop(context);
                          }
                        },
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.delete,
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
