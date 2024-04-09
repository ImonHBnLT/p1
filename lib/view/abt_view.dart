// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AbtView extends StatefulWidget {
  const AbtView({super.key});

  @override
  State<AbtView> createState() => _AbtViewState();
}

class _AbtViewState extends State<AbtView> {
  @override
  Widget build(BuildContext context) {
    String info = 'SOBRE\n\n\n   Aplicativo criado para P1 - PDM. \n\n   Desenvolvido no VSCode'+
                  '\nutilizando Flutter e Dart.\n\n\n\n                     Angelo F. Imon Spano\n\n\n\n\nVersão:0.007';

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 100, 50, 100),
        child: Column(
          children: [
            Text(
              info,
              style: TextStyle(fontSize: 16),
            ),
            Expanded(child: Container()),
            ElevatedButton(
              onPressed: () {
                  Navigator.pop(context);
              },
              child: Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
