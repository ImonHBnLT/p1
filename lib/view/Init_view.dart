// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

int lstindex = 0;

class InitView extends StatefulWidget {
  const InitView({super.key});

  @override
  State<InitView> createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {
  List<String> shoppingLists = ['Lista 1', 'Lista 2', 'Lista 3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Compras ${lstindex + 1}')),
      body: ListView.builder(
        itemCount: shoppingLists.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: GestureDetector(
              onLongPress: () async {
                final value = await showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(50.0, 50.0, 0.0, 0.0),
                  items: <PopupMenuEntry>[
                    PopupMenuItem(
                      value: 'rename',
                      child: Text('Renomear'),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Deletar'),
                    ),
                  ],
                );
                if (value == 'delete') {
                  setState(() {
                    shoppingLists.removeAt(index);
                  });
                } else if (value == 'rename') {
                  final newName = await showDialog<String>(
                    context: context,
                    builder: (context) => Builder(
                      builder: (innerContext) {
                        final controller = TextEditingController();
                        return AlertDialog(
                          title: Text('Renomear lista'),
                          content: TextField(
                            controller: controller,
                            autofocus: true,
                            decoration: InputDecoration(
                              labelText: 'Novo nome',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(innerContext).pop();
                              },
                            ),
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(innerContext).pop(controller.text);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  );
                  if (newName != null) {
                    setState(() {
                      shoppingLists[index] = newName;
                    });
                  }
                }
              },
              child: Text(shoppingLists[index]),
            ),
            onTap: () {
              lstindex = index;
              Navigator.pushNamed(context, 'lista',
                  arguments: shoppingLists[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            shoppingLists.add('Lista ${shoppingLists.length + 1}');
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
