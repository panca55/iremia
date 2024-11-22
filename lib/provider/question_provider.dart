import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iremia/models/diagnose_model.dart';
import 'package:iremia/models/question_model.dart';

class QuestionProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<QuestionModel> _questions = [
    QuestionModel(
      questionId: 1,
      questionText: 'Apakah Anda merasa mati rasa atau kesemutan?',
      cfPakar: 0.05,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Ringan', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Sedang', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Berat', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 2,
      questionText: 'Apakah Anda merasa panas?',
      cfPakar: 0.15,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Ringan', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Sedang', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Berat', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 3,
      questionText: 'Apakah kaki Anda gemetar?',
      cfPakar: 0.25,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Ringan', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Sedang', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Berat', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
  ];

  final Map<int, double> _cfResults = {}; // Hasil CF per pertanyaan
  final Map<int, int> _baiResults = {};
  double _finalCF = 0.0; // CF gabungan akhir
  int _totalBai = 0; // Total bobot BAI

  // Getters
  List<QuestionModel> get questions => _questions;
  double get finalCF => _finalCF;
  int get totalBai => _totalBai;

  QuestionModel getQuestionById(int id) {
    return _questions.firstWhere(
      (q) => q.questionId == id,
      orElse: () => throw Exception('Question with id $id not found'),
    );
  }
  

  

  Future<DiagnosisModel?> getDiagnosisByIdFromFirestore(String userId,
      String diagnosisId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('diagnoses')
          .doc(diagnosisId)
          .get();

      if (!snapshot.exists) {
        return null;
      }

      return DiagnosisModel.fromFirestore(snapshot.data()!);
    } catch (e) {
      throw Exception('Error fetching diagnosis: $e');
    }
  }

  void saveAnswer(int questionId, double cfUser, int bai) {
    final question = getQuestionById(questionId);
    final cfPakar = question.cfPakar;

    final cfResult = cfUser * cfPakar!;
    _cfResults[questionId] = cfResult;
    _baiResults[questionId] = bai;

    notifyListeners();
  }
  int calculateTotalBai() {
    _totalBai = _baiResults.values
        .fold(0, (sumBai, bai) => sumBai + bai); // Total bobot BAI
    notifyListeners();
    return _totalBai;
  }

  double calculateFinalCF() {
    double combinedCF = 0.0;
    for (var cf in _cfResults.values) {
      combinedCF = combinedCF + cf * (1 - combinedCF); // Kombinasi CF
    }
    _finalCF = combinedCF * 100;
    notifyListeners();
    return _finalCF;
  }

  String getDiagnosisResult() {
    if (_finalCF <= 7) {
      return "Tidak Anxiety";
    } else if (_finalCF <= 15) {
      return "Anxiety Ringan";
    } else if (_finalCF <= 25) {
      return "Anxiety Sedang";
    } else {
      return "Anxiety Berat";
    }
  }

  Future<void> saveDiagnosis(String userId) async {
    try {
      // Ambil referensi subkoleksi diagnosis untuk user
      final userDiagnosesRef =
          _firestore.collection('users').doc(userId).collection('diagnoses');

      // Ambil dokumen terakhir di subkoleksi diagnosa untuk mendapatkan ID terakhir
      final snapshot = await userDiagnosesRef
          .orderBy('diagnosisId', descending: true)
          .limit(1)
          .get();
      int newDiagnosisId =
          snapshot.docs.isEmpty ? 1 : int.parse(snapshot.docs.first.id) + 1;

      // Format tanggal
      DateTime currentDate = DateTime.now();
      String formattedDate =
          DateFormat('dd MMMM yyyy', 'id_ID').format(currentDate);

      // Buat diagnosis baru
      final diagnosis = DiagnosisModel(
        diagnosisId: newDiagnosisId.toString(),
        userId: userId,
        totalCf: _finalCF,
        totalBai: _totalBai,
        diagnosisResult: getDiagnosisResult(),
        dateDiagnosis: formattedDate,
      );

      // Simpan diagnosis ke Firestore
      await userDiagnosesRef.doc(diagnosis.diagnosisId).set({
        'diagnosisId': diagnosis.diagnosisId,
        'userId': diagnosis.userId,
        'totalCf': diagnosis.totalCf,
        'totalBai': diagnosis.totalBai,
        'diagnosisResult': diagnosis.diagnosisResult,
        'dateDiagnosis': diagnosis.dateDiagnosis, // String formatted
      });

      // Notifikasi listener
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving diagnosis: $e');
    }
  }

  Future<DiagnosisModel?> getLatestDiagnosis(String userId) async {
    try {
      final userDiagnosesRef =
          _firestore.collection('users').doc(userId).collection('diagnoses');

      final snapshot = await userDiagnosesRef
          .orderBy('diagnosisId', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        return DiagnosisModel.fromFirestore(data);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching latest diagnosis: $e');
      return null;
    }
  }
}
