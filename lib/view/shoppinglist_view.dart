// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';

class ShoppingListView extends StatefulWidget {
  const ShoppingListView({super.key});

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
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
