import 'package:flutter/material.dart';

class ArticlesModel extends ChangeNotifier {
  final int id;
  final String title;
  final String content;
  final String image;
  final Color color;
  final String author;
  final String publish;

  ArticlesModel({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.color,
    required this.author,
    required this.publish,
  });
}
