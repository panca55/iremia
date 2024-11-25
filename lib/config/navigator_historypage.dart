import 'package:flutter/material.dart';
import 'package:iremia/views/diagnose_history.dart';
import 'package:iremia/views/diagnose_result.dart';

class NavigatorHistorypage extends StatelessWidget {
  const NavigatorHistorypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => const DiagnoseHistory();
            break;
          case '/diagnose-result':
            builder = (BuildContext context) => const DiagnoseResult();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}