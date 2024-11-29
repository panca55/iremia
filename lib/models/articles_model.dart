import 'package:flutter/material.dart';

class ArticlesModel extends ChangeNotifier {
  final String? id;
  final String? title;
  final String? content;
  final String? image;
  final String? author;
  final String? publish;
  final DateTime? dateCreated;

  ArticlesModel({
    this.id,
    this.title,
    this.content,
    this.image,
    this.author,
    this.publish,
    this.dateCreated
  });
  factory ArticlesModel.fromFirestore(Map<String, dynamic> data) {
    return ArticlesModel(
        id: data['id'] as String,
        title: data['title'] as String?,
        content: data['content'] as String?,
        image: data['image'] as String?,
        author: data['author'] as String?,
        publish: data['publish'] as String?,
        dateCreated: (data['dateCreated']).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'author': author,
      'publish': publish,
      'dateCreated': dateCreated,
    };
  }
  ArticlesModel copyWith({
      String? id,
      String? title,
      String? content,
      String? image,
      String? author,
      String? publish,
      DateTime? dateCreated,
  }) {
    return ArticlesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
      author: author ?? this.author,
      publish: publish ?? this.publish,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }
}
