import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/users_provider.dart';
import 'pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Adicina o [UsersProvider] a raiz do projeto, fazendo com que ele se torne disponivel nas paginas internas
    return ChangeNotifierProvider(
      create: (context) => UsersProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter API Use',
        theme: ThemeData(
          colorSchemeSeed: Colors.pink,
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
