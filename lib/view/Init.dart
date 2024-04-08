// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Init extends StatefulWidget {
  const Init({super.key});

  @override
  State<Init> createState() => _InitState();
}

class ShoppingList {
  String name;
  List<String> items;

  ShoppingList(this.name, this.items);
}

class _InitState extends State<Init> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Minhas Listas de Compras')),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Lista ${index + 1}'),
            onTap: () {
              Navigator.pushNamed(context, 'lista');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createNewList(); 
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

 void _createNewList() {

  }
