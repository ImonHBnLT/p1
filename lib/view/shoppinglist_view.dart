// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ShoppingListView extends StatefulWidget {
  const ShoppingListView({super.key});

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  Map<String, List<Map<String, dynamic>>> shoppingLists = {};

  @override
  Widget build(BuildContext context) {
    final String listName =
        ModalRoute.of(context)!.settings.arguments as String? ?? 'List';
    return Scaffold(
      appBar: AppBar(
        title: Text(listName),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: shoppingLists[listName]?.length ?? 0,
        itemBuilder: (context, index) {
          return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: CheckboxListTile(
                title: Text('${shoppingLists[listName]![index]['nome']}'),
                subtitle: Text(
                    '${shoppingLists[listName]![index]['descricao']}\nQuantidade: ${shoppingLists[listName]![index]['quantidade']}'),
                value: shoppingLists[listName]![index]['comprado'] ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    shoppingLists[listName]![index]['comprado'] = value;
                  });
                },
                secondary: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        TextEditingController nomeController =
                            TextEditingController(
                                text: shoppingLists[listName]![index]['nome']);
                        TextEditingController descricaoController =
                            TextEditingController(
                                text: shoppingLists[listName]![index]
                                    ['descricao']);
                        TextEditingController quantidadeController =
                            TextEditingController(
                                text: shoppingLists[listName]![index]
                                        ['quantidade']
                                    .toString());
                        return AlertDialog(
                          title: Text('Editar Item'),
                          content: Column(
                            children: [
                              TextField(
                                controller: nomeController,
                                decoration: InputDecoration(hintText: 'Nome'),
                              ),
                              TextField(
                                controller: descricaoController,
                                decoration:
                                    InputDecoration(hintText: 'Descrição'),
                              ),
                              TextField(
                                controller: quantidadeController,
                                decoration:
                                    InputDecoration(hintText: 'Quantidade'),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: Text('Salvar'),
                              onPressed: () {
                                setState(() {
                                  shoppingLists[listName]![index]['nome'] =
                                      nomeController.text;
                                  shoppingLists[listName]![index]['descricao'] =
                                      descricaoController.text;
                                  shoppingLists[listName]![index]
                                          ['quantidade'] =
                                      int.parse(quantidadeController.text);
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                            TextButton(
                              child: Text('Remover'),
                              onPressed: () {
                                setState(() {
                                  shoppingLists[listName]!.removeAt(index);
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              TextEditingController nomeController = TextEditingController();
              TextEditingController descricaoController =
                  TextEditingController();
              TextEditingController quantidadeController =
                  TextEditingController();
              return AlertDialog(
                title: Text('Adicionar Item'),
                content: Column(
                  children: [
                    TextField(
                      controller: nomeController,
                      decoration: InputDecoration(hintText: 'Nome'),
                    ),
                    TextField(
                      controller: descricaoController,
                      decoration: InputDecoration(hintText: 'Descrição'),
                    ),
                    TextField(
                      controller: quantidadeController,
                      decoration: InputDecoration(hintText: 'Quantidade'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text('Adicionar'),
                    onPressed: () {
                      setState(() {
                        if (shoppingLists[listName] == null) {
                          shoppingLists[listName] = [];
                        }
                        shoppingLists[listName]!.add({
                          'nome': nomeController.text,
                          'descricao': descricaoController.text,
                          'quantidade': int.parse(quantidadeController.text),
                          'comprado': false,
                        });
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
