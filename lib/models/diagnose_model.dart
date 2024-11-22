import 'package:flutter/material.dart';

class DiagnosisModel extends ChangeNotifier {
  final String? diagnosisId;
  final String? userId;
  final double? totalCf;
  final int? totalBai;
  final String? diagnosisResult;
  final String? dateDiagnosis;

  DiagnosisModel({
    this.diagnosisId,
    this.userId,
    this.totalCf,
    this.totalBai,
    this.diagnosisResult,
    this.dateDiagnosis,
  });

  factory DiagnosisModel.fromFirestore(Map<String, dynamic> data) {
    return DiagnosisModel(
      diagnosisId: data['diagnosisId'] as String?,
      userId: data['userId'] as String?,
      totalCf: (data['totalCf'] as num?)?.toDouble(),
      totalBai: (data['totalBai'] as num?)?.toInt(),
      diagnosisResult: data['diagnosisResult'] as String?,
      dateDiagnosis: data['dateDiagnosis'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'diagnosisId': diagnosisId,
      'userId': userId,
      'totalCf': totalCf,
      'totalBai': totalBai,
      'diagnosisResult': diagnosisResult,
      'dateDiagnosis': dateDiagnosis,
    };
  }
}
