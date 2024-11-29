import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iremia/provider/articles_provider.dart';
import 'package:iremia/theme/global_color_theme.dart';
import 'package:iremia/views/admin/add_article.dart';
import 'package:iremia/views/admin/edit_article.dart';
import 'package:iremia/views/article_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class ArticleAdminPage extends StatelessWidget {
  static String routename = '/article-admin-page';
  const ArticleAdminPage({super.key});

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'List Artikel',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                      context,
                      settings: const RouteSettings(name: AddArticle.routname),
                      screen: const AddArticle(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: GlobalColorTheme.successColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 4))
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.add_circle_sharp,
                          size: 12,
                          color: Colors.white,
                        ),
                        Text('TAMBAH',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            // Menggunakan FutureBuilder
            Expanded(
              child: FutureBuilder(
                future: articlesProvider.fetchArticles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Failed to load articles'),
                    );
                  } else {
                    return Consumer<ArticlesProvider>(
                      builder: (context, provider, child) {
                        if (provider.articleList.isEmpty) {
                          return const Center(
                            child: Text('No articles available'),
                          );
                        }
                        return ListView.separated(
                          itemCount: provider.articleList.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 14),
                          itemBuilder: (context, index) {
                            final article = provider.articleList[index];
                            return GestureDetector(
                              onTap: () {
                                PersistentNavBarNavigator
                                    .pushNewScreenWithRouteSettings(
                                  context,
                                  settings: RouteSettings(
                                      name: ArticlePage.routeName),
                                  screen: ArticlePage(article: article),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: GlobalColorTheme.primaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 4),
                                      blurRadius: 4,
                                      color: Colors.black.withOpacity(0.25),
                                    )
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    article.image!),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: GlobalColorTheme
                                                    .primaryColor,
                                                width: 1),
                                          ),
                                        ),
                                        const SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              article.title ?? 'No Title',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${article.author} | ${article.publish}',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            PersistentNavBarNavigator
                                                .pushNewScreenWithRouteSettings(
                                              context,
                                              settings: const RouteSettings(
                                                  name: EditArticle.routname),
                                              screen:
                                                  EditArticle(article: article),
                                              withNavBar: false,
                                              pageTransitionAnimation:
                                                  PageTransitionAnimation
                                                      .cupertino,
                                            );
                                          },
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                border: Border.all(
                                                  width: 0.2,
                                                  color: Colors.black,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: const Offset(0, 4),
                                                    blurRadius: 4,
                                                    color: Colors.black
                                                        .withOpacity(0.25),
                                                  )
                                                ],
                                              ),
                                              child: const Icon(
                                                  Icons.edit_note_outlined)),
                                        ),
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {
                                            articlesProvider.deleteArticle(
                                                article.id!, article.image);
                                          },
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color:
                                                    GlobalColorTheme.errorColor,
                                                border: Border.all(
                                                  width: 0.2,
                                                  color: Colors.black,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: const Offset(0, 4),
                                                    blurRadius: 4,
                                                    color: Colors.black
                                                        .withOpacity(0.25),
                                                  )
                                                ],
                                              ),
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
