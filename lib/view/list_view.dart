// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';

class ListView extends StatefulWidget {
  const ListView({super.key});

  @override
  State<ListView> createState() => _ListViewState();
}

class _ListViewState extends State<ListView> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Lista de Compras ${1 + 1}')),
      body: Center(child: Text('Itens da lista de compras aqui')),
    );
  }
}

void main() {

}
