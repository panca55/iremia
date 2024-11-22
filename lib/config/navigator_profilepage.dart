import 'package:flutter/material.dart';
import 'package:iremia/views/edit_profile_page.dart';
import 'package:iremia/views/login_page.dart';
import 'package:iremia/views/profile_page.dart';

class NavigatorProfilepage extends StatelessWidget {
  const NavigatorProfilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => const ProfilePage();
            break;
          case '/edit-profile-page':
            builder = (BuildContext context) => const EditProfilePage();
            break;
          case '/login-page':
            builder = (BuildContext context) => const LoginPage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}