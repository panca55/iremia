import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iremia/provider/articles_provider.dart';
import 'package:iremia/views/widgets/card_home.dart';
import 'package:iremia/views/widgets/list_articles.dart';
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
            ListArticles(articlesProvider: articlesProvider)
          ],
        ),
      ),
    );
  }
}


