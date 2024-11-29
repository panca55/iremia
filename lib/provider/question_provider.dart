import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iremia/models/diagnose_model.dart';
import 'package:iremia/models/question_model.dart';
import 'package:uuid/uuid.dart';
class QuestionProvider with ChangeNotifier {
  final Uuid _uuid = const Uuid();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<DiagnosisModel> _diagnose = [];
  List<DiagnosisModel> get diagnose => _diagnose;

  final List<DiagnosisModel> _diagnoseRecap = [];
  List<DiagnosisModel> get diagnoseRecap => _diagnoseRecap;

  final List<QuestionModel> _questions = [
    QuestionModel(
      questionId: 1,
      questionText: 'Apakah kamu sering merasa mati rasa atau kesemutan?',
      cfPakar: 0.05,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 2,
      questionText: 'Apakah kamu sering merasa kepanasan?',
      cfPakar: 0.05,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 3,
      questionText: 'Apakah kakimu sering merasa gemetar?',
      cfPakar: 0.15,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 4,
      questionText: 'Apakah kamu merasa sulit untuk bersantai?',
      cfPakar: 0.05,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 5,
      questionText: 'Apakah kamu takut sesuatu yang buruk akan terjadi?',
      cfPakar: 0.15,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 6,
      questionText: 'Apakah kamu sering merasa pusing?',
      cfPakar: 0.05,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 7,
      questionText: 'Apakah kamu merasa jantungmu berdebar-debar?',
      cfPakar: 0.15,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 8,
      questionText: 'Apakah kamu merasa tidak stabil saat berdiri?',
      cfPakar: 0.25,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 9,
      questionText: 'Apakah kamu merasa ketakutan atau panik secara tiba-tiba?',
      cfPakar: 0.25,  
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 10,
      questionText: 'Apakah kamu merasa tegang atau gugup?',
      cfPakar: 0.05,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 11,
      questionText: 'Apakah kamu sering merasa seperti tercekik?',
      cfPakar: 0.15,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 12,
      questionText: 'Apakah tanganmu sering gemetar?',
      cfPakar: 0.15,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 13,
      questionText: 'Apakah kamu merasa tidak stabil saat berjalan?',
      cfPakar: 0.25,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 14,
      questionText: 'Apakah kamu merasa takut kehilangan kendali?',
      cfPakar: 0.05,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 15,
      questionText: 'Apakah kamu sering merasa sulit bernafas?',
      cfPakar: 0.25,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 16,
      questionText: 'Apakah kamu sering merasa takut mati?',
      cfPakar: 0.25,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 17,
      questionText: 'Apakah kamu sering merasa sangat ketakutan?',
      cfPakar: 0.15,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 18,
      questionText: 'Apakah kamu sering mengalami gangguan pencernaan?',
      cfPakar: 0.25,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 19,
      questionText: 'Apakah kamu sering merasa kepala ringan, seperti ingin pingsan?',
      cfPakar: 0.25,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 20,
      questionText: 'Apakah wajahmu sering memerah?',
      cfPakar: 0.05,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
      ],
    ),
    QuestionModel(
      questionId: 21,
      questionText: 'Apakah kamu sering berkeringat panas atau dingin secara tiba-tiba?',
      cfPakar: 0.15,
      answers: [
        {'text': 'Tidak sama sekali', 'cfUser': 0.0, 'bai': 0},
        {'text': 'Terkadang', 'cfUser': 0.1, 'bai': 1},
        {'text': 'Cukup sering', 'cfUser': 0.2, 'bai': 2},
        {'text': 'Sering', 'cfUser': 0.3, 'bai': 3},
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
  

  

  Future<DiagnosisModel?> getDiagnosisByIdFromFirestore(
      String diagnosisId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
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

  Future<void> getHistoryDiagnosis(
      String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('diagnoses')
          .where('userId', isEqualTo: userId)
          .get();
      
      final fetchHistory= querySnapshot.docs
          .map((doc) => DiagnosisModel.fromFirestore(doc.data()))
          .toList();
      _diagnose.clear();
      _diagnose.addAll(fetchHistory);
      notifyListeners();
    } catch (e) {
      throw Exception('Error fetching diagnoses: $e');
    }
  }
  
  Future<void> deleteDiagnosis(String diagnosaId) async {
    try {
      // 1. Hapus artikel dari Firestore
      await _firestore.collection('diagnoses').doc(diagnosaId).delete();
      _diagnose.removeWhere((diagnose) => diagnose.diagnosisId == diagnosaId);
      notifyListeners();
      debugPrint('Diagnosa berhasil dihapus.');
    } catch (e) {
      debugPrint('Gagal menghapus artikel: $e');
      throw Exception('Gagal menghapus artikel: $e');
    }
  }
  final Map<int, int> _selectedAnswers = {};
  int? getSelectedAnswerIndex(int questionId) {
    return _selectedAnswers[questionId];
  }
  void resetAnswers() {
    _selectedAnswers.clear();
    notifyListeners();
  }
  void saveAnswer(int questionId, double cfUser, int bai, int selectedIndex) {
    final question = getQuestionById(questionId);
    final cfPakar = question.cfPakar;

    final cfResult = cfUser * cfPakar!;
    _cfResults[questionId] = cfResult;
    debugPrint('${cfUser.toString()} * ${cfPakar.toString()} = ${_cfResults[questionId].toString()}');
    _baiResults[questionId] = bai;
    _selectedAnswers[questionId] = selectedIndex;

    notifyListeners();
  }
  int calculateTotalBai() {
    _totalBai = _baiResults.values
        .fold(0, (sumBai, bai) => sumBai + bai); // Total bobot BAI
    notifyListeners();
    return _totalBai;
  }

  double calculateFinalCF() {
    double combinedCF = _cfResults.values.first;
    for (var cf in _cfResults.values) {
      combinedCF = combinedCF + cf * (1 - combinedCF); // Kombinasi CF
      debugPrint("combinedCF = $combinedCF");
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
  String getSolution() {
    if (_finalCF <= 7) {
      return '';
    } else if (_finalCF <= 15) {
      return '''a. Memberikan penguatan / menenangkan\nb. Memberikan sugesti yang positif dan membangun\nc. Mengarahkan pengguna untuk memberikan sugesti positif ke diri sendiri\nd. menganjurkan makan makanan yang sehat, tidur yang cukup dan olahraga yang teratur''';
    } else if (_finalCF <= 25) {
      return '''a. Mengarahkan pengguna untuk menenangkan diri\nb. Apabila pengguna merasa tidak ada perbaikan atau perubahan, maka dianjurkan untuk konsultasi dengan orang yang profesional''';
    } else {
      return '''Dianjurkan untuk konsultasi dengan orang yang profesional untuk mendapat penanganan lebih lanjut''';
    }
  }

  Future<void> saveDiagnosis(String userId) async {
    try {
      // Ambil referensi subkoleksi diagnosis untuk user
      final userDiagnosesRef =_firestore.collection('diagnoses');

      final diagnoseId = _uuid.v4();

      // Format tanggal
      DateTime currentDate = DateTime.now();
      String formattedDate =
          DateFormat('dd MMMM yyyy', 'id_ID').format(currentDate);

      // Buat diagnosis baru
      final diagnosis = DiagnosisModel(
        diagnosisId: diagnoseId,
        userId: userId,
        totalCf: _finalCF,
        totalBai: _totalBai,
        diagnosisResult: getDiagnosisResult(),
        solution: getSolution(),
        dateDiagnosis: formattedDate,
        dateCreated: DateTime.now()
      );

      // Simpan diagnosis ke Firestore
      await userDiagnosesRef.doc(diagnosis.diagnosisId).set({
        'diagnosisId': diagnosis.diagnosisId,
        'userId': diagnosis.userId,
        'totalCf': diagnosis.totalCf,
        'totalBai': diagnosis.totalBai,
        'diagnosisResult': diagnosis.diagnosisResult,
        'solution': diagnosis.solution,
        'dateDiagnosis': diagnosis.dateDiagnosis,
        'dateCreated': FieldValue.serverTimestamp(),
      });

      // Notifikasi listener
      _diagnose.add(diagnosis);
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving diagnosis: $e');
    }
  }

  Future<DiagnosisModel?> getLatestDiagnosis(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('diagnoses')
          .where('userId', isEqualTo: userId)
          .orderBy('dateCreated', descending: true)
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
  Future<void> getRecapDiagnosis (List<String> userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('diagnoses')
          .where('userId', isEqualTo: userId)
          .orderBy('dateCreated', descending: true)
          .get();

      final fetchHistory = querySnapshot.docs
          .map((doc) => DiagnosisModel.fromFirestore(doc.data()))
          .toList();
      _diagnoseRecap.clear();
      _diagnoseRecap.addAll(fetchHistory);
      notifyListeners();
    } catch (e) {
      throw Exception('Error fetching diagnoses: $e');
    }
  }
}
