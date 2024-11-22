import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iremia/provider/articles_provider.dart';
import 'package:iremia/views/article_page.dart';
import 'package:iremia/views/widgets/card_home.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final articlesProvider =
        Provider.of<ArticlesProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'IREMIA',
              style: GoogleFonts.poppins(
                  color: const Color(0xFF40BFFF),
                  fontSize: 33,
                  fontWeight: FontWeight.bold),
            ),
            const CardHome(),
            const SizedBox(height: 20),
            Text(
              'Artikel',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final article = articlesProvider.articleList[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      height: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: article.color,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.25),
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                article.title,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                          GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator
                                  .pushNewScreenWithRouteSettings(
                                context,
                                settings:
                                    RouteSettings(name: ArticlePage.routeName),
                                screen: ArticlePage(article: article),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 30),
                              alignment: Alignment.bottomRight,
                              height: 27,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 3.5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0.2,
                                    color: Colors.black,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 4),
                                      blurRadius: 4,
                                      color: Colors.black.withOpacity(0.25),
                                    )
                                  ]),
                              child: Text(
                                'BACA',
                                style: GoogleFonts.poppins(
                                    color: const Color(0xFF000000),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 14,
                      ),
                  itemCount: articlesProvider.articleList.length),
            )
          ],
        ),
      ),
    );
  }
}
