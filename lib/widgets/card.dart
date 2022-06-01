import 'package:flutter/material.dart';

class BuildCard extends StatefulWidget {
  final String titulo;
  final String descricao;

  BuildCard({this.titulo, this.descricao});

  @override
  _BuildCardState createState() => _BuildCardState();
}

class _BuildCardState extends State<BuildCard> {
  bool feito = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: feito ? Colors.green[100] : Colors.white,
            borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 3),
                  child: GestureDetector(
                    onTap: () {
                      if (feito != true) {
                        feito = true;
                      } else {
                        feito = false;
                      }
                      setState(() {});
                    },
                    child: Container(
                      child: feito
                          ? Icon(
                              Icons.check,
                              size: 16,
                            )
                          : null,
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: feito ? Colors.green[300] : Colors.white70,
                          borderRadius: BorderRadius.circular(6),
                          border: feito
                              ? null
                              : Border.all(color: Colors.grey, width: 2)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.titulo ?? "Sem titulo",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      color: feito ? Colors.green : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 41),
                    child: Text(widget.descricao ?? "Adicione uma descrição",
                        style: TextStyle(
                          color: feito ? Colors.green : Colors.black,
                          fontSize: 15,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
