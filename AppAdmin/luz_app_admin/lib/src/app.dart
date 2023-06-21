import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:luz_app_admin/src/content/upload_image.dart';
import 'package:luz_app_admin/src/main_menu.dart';

import 'clients/list_client.dart';
import 'clients/client_details_view.dart';
import 'content/content.dart';
import 'google_sign_in_screen.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

import 'package:firebase_auth/firebase_auth.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'pt-br'),
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            // if (!isUserAuthenticated()) {
            //   // Se o usuário não estiver autenticado, redirecione-o para a tela de autenticação
            //   print(isUserAuthenticated);
            //   return MaterialPageRoute<void>(
            //     settings: routeSettings,
            //     builder: (BuildContext context) => GoogleSignInScreen(),
            //   );
            // }

            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                if (!isUserAuthenticated()) {
                  print("------------------------------> Não autenticado");
                  return GoogleSignInScreen();
                } else {
                  print("------------------------------>");
                  print(FirebaseAuth.instance.currentUser);
                  switch (routeSettings.name) {
                    case SettingsView.routeName:
                      return SettingsView(controller: settingsController);
                    case ClientDetailsView.routeName:
                      return const ClientDetailsView();
                    case ListClient.routeName:
                      return const ListClient();
                    case UploadImage.routeName:
                      return const UploadImage();
                    case Content.routeName:
                      return const Content();
                    case MainMenu.routeName:
                      return const MainMenu();
                    default:
                      return const MainMenu();
                  }
                }
              },
            );
          },
        );
      },
    );
  }

  bool isUserAuthenticated() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}
