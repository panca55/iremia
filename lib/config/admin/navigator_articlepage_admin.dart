import 'package:flutter/material.dart';
import 'package:iremia/views/admin/add_article.dart';
import 'package:iremia/views/admin/article_admin_page.dart';
import 'package:iremia/views/article_page.dart';

class NavigatorArticlepageAdmin extends StatelessWidget {
  const NavigatorArticlepageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => const ArticleAdminPage();
            break;
          case '/article-page':
            builder = (BuildContext context) => const ArticlePage();
            break;
          case '/add-article':
            builder = (BuildContext context) => const AddArticle();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}