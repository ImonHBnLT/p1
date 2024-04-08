// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

var formKey = GlobalKey<FormState>();
var txtValor1 = TextEditingController();
var txtValor2 = TextEditingController();


class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 100, 50, 100),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 30),
              TextFormField(
                controller: txtValor1,
                style: TextStyle(fontSize: 32),
                decoration: InputDecoration(
                  labelText: 'email',
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
              TextFormField(
                controller: txtValor2,
                style: TextStyle(fontSize: 32),
                decoration: InputDecoration(
                  labelText: 'senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.key),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite a senha';
                  } else if (double.tryParse(value) == null) {
                    return 'Digite uma senha válida';
                  } else {
                    if (value != '1234') {
                      return 'Senha incorreta';
                    }
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
                        content: Text('Bem vindo!'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                    Navigator.pushNamed(context, 'inicio');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('email ou senha inválidos.'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: Text('OK'),
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
                  Navigator.pushNamed(context, 'cadastro');
                },
                child: Text('Cadastrar Usuário'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool validateEmail(String email) {
  // Regular expression pattern for a valid email address
  const pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
  return RegExp(pattern).hasMatch(email);
}
