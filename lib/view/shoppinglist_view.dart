// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ShoppingListView extends StatefulWidget {
  const ShoppingListView({super.key});

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  Map<String, List<Map<String, dynamic>>> shoppingLists = {};
  List<Map<String, dynamic>>? searchResults;

  @override
  Widget build(BuildContext context) {
    final String listName =
        ModalRoute.of(context)!.settings.arguments as String? ?? 'List';
    return Scaffold(
      appBar: AppBar(
        title: Text(listName),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 22.5),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    String searchQuery = '';
                    return AlertDialog(
                      title: Text('Buscar Item'),
                      content: TextField(
                        onChanged: (value) {
                          searchQuery = value;
                        },
                      ),
                      actions: <Widget>[
                        TextButton(
                            child: Text('Buscar'),
                            onPressed: () {
                              searchResults = buscarItems(searchQuery);
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Resultados da Busca'),
                                    content: SizedBox(
                                      width: double.maxFinite,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: searchResults?.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Text(searchResults?[index]
                                                    ['nome'] ??
                                                ''),
                                            subtitle: Text(searchResults?[index]
                                                    ['descricao'] ??
                                                ''),
                                            trailing: Text(
                                                'Quantidade: ${searchResults?[index]['quantidade'] ?? ''}'),
                                          );
                                        },
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Fechar'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
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
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Remover'),
                              onPressed: () {
                                setState(() {
                                  shoppingLists[listName]!.removeAt(index);
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Salvar'),
                              onPressed: () {
                                setState(() {
                                  Map<String, dynamic> item =
                                      shoppingLists[listName]![index];
                                  alterarNome(item, nomeController.text);
                                  alterarDescricao(
                                      item, descricaoController.text);
                                  alterarQuantidade(item,
                                      int.parse(quantidadeController.text));
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

  void alterarNome(Map<String, dynamic> item, String novoNome) {
    item['nome'] = novoNome;
  }

  void alterarDescricao(Map<String, dynamic> item, String novaDescricao) {
    item['descricao'] = novaDescricao;
  }

  void alterarQuantidade(Map<String, dynamic> item, int novaQuantidade) {
    item['quantidade'] = novaQuantidade;
  }

  List<Map<String, dynamic>> buscarItems(String query) {
    List<Map<String, dynamic>> results = [];

    for (var listName in shoppingLists.keys) {
      var items = shoppingLists[listName];
      if (items != null) {
        for (var item in items) {
          if (item['nome'].toLowerCase().contains(query.toLowerCase()) ||
              item['descricao'].toLowerCase().contains(query.toLowerCase())) {
            results.add(item);
          }
        }
      }
    }

    return results;
  }
}
