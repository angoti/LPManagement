import 'package:flutter/material.dart';
import 'package:luz_app_admin/src/clients/list_client.dart';
import 'package:luz_app_admin/src/settings/settings_view.dart';

import 'content/content.dart';

class MainMenu extends StatelessWidget {
  static const routeName = '/Menu';

  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.restorablePushNamed(context, ListClient.routeName);
              },
              child: Text('Clientes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.restorablePushNamed(context, Content.routeName);
              },
              child: Text('Gerenciar Conteúdo'),
            ),
          ],
        ),
      ),
    );
  }
}
