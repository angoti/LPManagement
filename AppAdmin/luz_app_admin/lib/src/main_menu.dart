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
        title: const Text('Menu'),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.restorablePushNamed(context, ListClient.routeName);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: const Text('Clientes'),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.restorablePushNamed(context, Content.routeName);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: const Text('Gerenciar Conteúdo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
