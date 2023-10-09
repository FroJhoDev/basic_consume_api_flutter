import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/users_provider.dart';

class CreateUserPage extends StatelessWidget {
  CreateUserPage({super.key});

  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _userTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _phoneTextEditingController =
      TextEditingController();
  final TextEditingController _websiteTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Novo Usuario'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTextEditingController,
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                ),
                TextFormField(
                  controller: _userTextEditingController,
                  decoration: const InputDecoration(
                    label: Text('Usuario'),
                  ),
                ),
                TextFormField(
                  controller: _emailTextEditingController,
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                ),
                TextFormField(
                  controller: _phoneTextEditingController,
                  decoration: const InputDecoration(
                    label: Text('Telefone'),
                  ),
                ),
                TextFormField(
                  controller: _websiteTextEditingController,
                  decoration: const InputDecoration(
                    label: Text('Site'),
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: FilledButton(
                    child: const Text('Salvar Informacoes'),
                    onPressed: () {
                      final UserModel user = UserModel(
                        name: _nameTextEditingController.text,
                        username: _userTextEditingController.text,
                        email: _emailTextEditingController.text,
                        phone: _phoneTextEditingController.text,
                        website: _websiteTextEditingController.text,
                      );

                      Provider.of<UsersProvider>(context, listen: false)
                          .createUser(user)
                          .then(
                            (_) => {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    'Usuario Cadastrado com sucesso!',
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('Ok'),
                                      onPressed: () {
                                        Navigator.of(context).popUntil((route) => route.isFirst);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            },
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
