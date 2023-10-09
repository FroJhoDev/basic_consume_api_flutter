import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/users_provider.dart';

class EditUserPage extends StatefulWidget {
  final UserModel user;

  const EditUserPage({
    super.key,
    required this.user,
  });

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
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
  void initState() {
    _nameTextEditingController.text = widget.user.name;
    _userTextEditingController.text = widget.user.username;
    _emailTextEditingController.text = widget.user.email;
    _phoneTextEditingController.text = widget.user.phone;
    _websiteTextEditingController.text = widget.user.website;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Usuario'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(
              children: [
                TextFormField(
                  // controller: _nameTextEditingController,
                  initialValue: widget.user.name,
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
                    child: const Text('Salvar Alteracoes'),
                    onPressed: () {
                      final UserModel user = UserModel(
                        id: widget.user.id,
                        name: _nameTextEditingController.text,
                        username: _userTextEditingController.text,
                        email: _emailTextEditingController.text,
                        phone: _phoneTextEditingController.text,
                        website: _websiteTextEditingController.text,
                      );

                      Provider.of<UsersProvider>(context, listen: false)
                          .updateUser(user)
                          .then(
                            (_) => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text(
                                  'Usuario Atualizado com sucesso!',
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                    },
                                  ),
                                ],
                              ),
                            ),
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
