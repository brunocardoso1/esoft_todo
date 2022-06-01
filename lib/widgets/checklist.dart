import 'package:flutter/material.dart';

class CheckList extends StatelessWidget {
  final String texto;
  bool feito;

  CheckList({this.texto, @required this.feito});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
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
                color: feito ? Colors.green[200] : Colors.white70,
                borderRadius: BorderRadius.circular(6),
                border:
                    feito ? null : Border.all(color: Colors.grey, width: 2)),
          ),
        ),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(texto ?? "Insira o titulo da tarefa"),
        )),
      ],
    ));
  }
}
