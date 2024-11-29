import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LatestDiagnosesProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _latestDiagnoses = [];

  List<Map<String, dynamic>> get latestDiagnoses => _latestDiagnoses;

  Future<void> fetchLatestDiagnoses() async {
    try {
      // Ambil semua pengguna
      final usersSnapshot = await _firestore.collection('users').get();
      final List<Map<String, dynamic>> diagnosesList = [];

      for (var userDoc in usersSnapshot.docs) {
        final userId = userDoc.id;
        final userData = userDoc.data();

        // Ambil diagnosa terbaru untuk pengguna ini
        final diagnosesSnapshot = await _firestore
            .collection('diagnoses')
            .where('userId', isEqualTo: userId)
            .orderBy('dateCreated', descending: true)
            .limit(1)
            .get();

        if (diagnosesSnapshot.docs.isNotEmpty) {
          final diagnosis = diagnosesSnapshot.docs.first.data();

          diagnosesList.add({
            'userId': userData['userId'] ?? 'Tidak diketahui',
            'name': userData['name'] ?? 'Tidak diketahui',
            'age': userData['age'] ?? '-',
            'gender': userData['gender'] ?? '-',
            'diagnosisResult':
                diagnosis['diagnosisResult'] ?? 'Tidak ada hasil',
            'solution':
                diagnosis['solution'] ?? 'Tidak ada hasil',
            'dateDiagnosis': diagnosis['dateDiagnosis'] ?? '-',
            'totalCf': diagnosis['totalCf'] ?? 0.0,
            'diagnosisId': diagnosis['diagnosisId'],
          });
        }
      }

      _latestDiagnoses = diagnosesList;
    } catch (e) {
      debugPrint('Error fetching diagnoses: $e');
    }
  }
}
