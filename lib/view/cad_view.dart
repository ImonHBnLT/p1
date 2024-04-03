// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:math';

class CadView extends StatefulWidget {
  const CadView({super.key});

  @override
  State<CadView> createState() => _CadViewState();
}

var formKey = GlobalKey<FormState>();
var txtValor1 = TextEditingController();
String txtSenha="a";

class _CadViewState extends State<CadView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 100, 50, 100),
        child: Center(
          child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 30),
              TextFormField(
                controller: txtValor1,
                style: TextStyle(fontSize: 32),
                decoration: InputDecoration(
                  labelText: 'Digite seu email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.mail),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Digite o email';
                  } else if (value.isEmpty) {
                    return 'Digite o email';
                  } else if (!validateEmail(value)) {
                    return 'Digite um email válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  foregroundColor: Colors.blue.shade900,
                  minimumSize: Size(200, 50),
                  shadowColor: Colors.red,
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Senha Gerada com Sucesso!'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                    txtSenha = generateRandomString();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Digite um e-mail válido!'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: Text('Gerar Senha'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  foregroundColor: Colors.blue.shade900,
                  minimumSize: Size(200, 50),
                  shadowColor: Colors.red,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Voltar Para Login'),
              ),
            ],
          ),
        ),
      ),
        )
    );
  }
}

bool validateEmail(String email) {
  // Regular expression pattern for a valid email address
  const pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
  return RegExp(pattern).hasMatch(email);
}

String generateRandomString() {
  final random = Random();
  final characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+[]{}|;:,.<>?';
  final randomString = List.generate(6, (index) => characters[random.nextInt(characters.length)]).join();
  return randomString;
}
