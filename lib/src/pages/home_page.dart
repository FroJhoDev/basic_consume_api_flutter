import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/users_provider.dart';

import 'create_user_page.dart';
import 'edit_user_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Faz uma instacia do UsersProvider e coloca na variavel, permitindo a utilzacao da variavel para acessar as funcoes
    final userProvider = Provider.of<UsersProvider>(context);

    // Faz a Listagem de Usuarios com os dados da API
    userProvider.readUsers();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
        centerTitle: true,
      ),
      body: userProvider.userList.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              itemCount: userProvider.userList.length,
              itemBuilder: (context, index) {
                final UserModel user = userProvider.userList[index];

                return ListTile(
                  tileColor: index.isEven
                      ? Colors.transparent
                      : Theme.of(context).colorScheme.primary.withOpacity(0.05),
                  leading: CircleAvatar(
                    child: Text(
                      user.id.toString(),
                    ),
                  ),
                  title: Text(user.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.email),
                      Text(
                        user.phone,
                        style:
                            const TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () {
                    // Faz a navegacao ate a pagina de Editar Usuario
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditUserPage(user: user),
                      ),
                    );
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Atencao'),
                        content: Text(
                            'Tem certeza que deseja deletar o usuario ${user.name}?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Ativa a funcao de Deletar um Usuario, e quando concluida, fecha o Dialog
                              Provider.of<UsersProvider>(context, listen: false)
                                  .deleteUser(user.id.toString())
                                  .then((_) => Navigator.of(context).pop());
                            },
                            child: const Text('Sim, DELETAR'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.person_add,
        ),
        onPressed: () {
          // Faz a navegacao ate a pagina de Criar de Usuario
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateUserPage(),
            ),
          );
        },
      ),
    );
  }
}
