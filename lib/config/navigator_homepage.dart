
import 'package:flutter/material.dart';
import 'package:iremia/views/article_page.dart';
import 'package:iremia/views/home_page.dart';
import 'package:iremia/views/questionaire_page.dart';

class NavigatorHomepage extends StatelessWidget {
  const NavigatorHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => const HomePage();
            break;
          case '/question-page':
            builder = (BuildContext context) => const QuestionnairePage();
            break;
          case '/article-page':
            builder = (BuildContext context) => const ArticlePage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}