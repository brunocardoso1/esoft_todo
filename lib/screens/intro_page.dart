import 'package:esoft_todo/utilidades/colors.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: roxo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: 'Bem-vindo a \n',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    )),
                TextSpan(
                    text: 'E-Soft Sistemas! \n',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Tudo sob controle.",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                child: Text(
                  "Começar anotações!",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  primary: laranja,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
