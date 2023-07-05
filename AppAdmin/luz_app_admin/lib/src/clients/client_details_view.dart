import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class ClientDetailsView extends StatelessWidget {
  const ClientDetailsView({super.key});

  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String name = arguments['name'] ?? '';
    final String email = arguments['email'] ?? '';
    final String phone = arguments['phone'] ?? '';
    final String segments = arguments['segments'] ?? '';

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes do cliente'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Nome: $name'),
              Text('E-mail: $email'),
              Text('Telefone: $phone'),
              Text('Categorias de interesse: $segments'),
            ],
          ),
        ));
  }
}
