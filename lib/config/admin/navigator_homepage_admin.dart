import 'package:flutter/material.dart';
import 'package:iremia/views/admin/admin_home_page.dart';
import 'package:iremia/views/admin/diagnose_result_all.dart';
import 'package:iremia/views/admin/users_diagnose_history.dart';

class NavigatorHomepageAdmin extends StatelessWidget {
  const NavigatorHomepageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => const AdminHomePage();
            break;
          case '/diagnose-result-all':
            builder = (BuildContext context) => const DiagnoseResultAll();
            break;
          case '/users-diagnose-history':
            builder = (BuildContext context) => const UsersDiagnoseHistory();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}