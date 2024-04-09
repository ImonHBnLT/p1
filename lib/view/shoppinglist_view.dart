// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:p1/view/Init_view.dart';

class ShoppingListView extends StatefulWidget {
  const ShoppingListView({super.key});

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  @override
  Widget build(BuildContext context) {
    final String listName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text(listName)),
      body: Center(child: Text('Itens da lista de compras aqui')),
    );
  }
}

void main() {

}
