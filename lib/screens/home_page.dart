import 'package:esoft_todo/data/data_provider.dart';
import 'package:esoft_todo/screens/cadastro_page.dart';
import 'package:esoft_todo/utilidades/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataProvider _dbprovider = DataProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 65),
          child: Text(
            "Bem vindo(a)!",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      backgroundColor: roxo,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Stack(
            children: [
              FutureBuilder(
                initialData: [],
                future: _dbprovider.getTarefa(),
                builder: (context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CadastrarTODO(
                                        tarefa: snapshot.data[index],
                                      ))).then((value) {
                            setState(() {});
                          });
                        },
                        child: BuildCard(
                          titulo: snapshot.data[index].titulo,
                          descricao: snapshot.data[index].descricao,
                        ),
                      );
                    },
                  );
                },
              ),
              Positioned(
                  bottom: 20,
                  right: 0,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CadastrarTODO(
                                  tarefa: null,
                                )),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                    backgroundColor: laranja,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
