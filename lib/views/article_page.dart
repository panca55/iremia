import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iremia/models/articles_model.dart';
import 'package:iremia/provider/articles_provider.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatelessWidget {
  final ArticlesModel? article;
  static String routeName = '/article';

  const ArticlePage({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    final articles = Provider.of<ArticlesProvider>(context)
        .articleList
        .where((a) => a.id != article?.id)
        .toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text(article!.title, style: GoogleFonts.poppins(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),),
        leading: const BackButton(color: Colors.black,),
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,

      ),
      body: Padding(
        padding: const EdgeInsets.only(left:16.0, right: 16.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              article!.title,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'By ${article!.author} | ${article!.publish}',
              style: const TextStyle(
                  color: Colors.grey, fontStyle: FontStyle.italic),
            ),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              article!.content,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            const Text(
              'Artikel Lainnya',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final otherArticle = articles[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ArticlePage(article: otherArticle),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: otherArticle.color,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                otherArticle.title,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                otherArticle.author,
                                style: GoogleFonts.poppins(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                itemCount: articles.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
