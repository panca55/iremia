import 'package:flutter/material.dart';

class QuestionModel extends ChangeNotifier {
  final int? questionId;
  final String? questionText;
  final double? cfPakar;
  final List<Map<String, dynamic>>? answers;

  QuestionModel({
    this.questionId,
    this.questionText,
    this.cfPakar,
    this.answers,
  });
}
