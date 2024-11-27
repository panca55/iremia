import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfRecapController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Membuat PDF dengan diagnosa terbaru dari semua pengguna
  Future<pw.Document> createLatestDiagnosesPdf(BuildContext context) async {
    final pdf = pw.Document();

    try {
      // Ambil semua pengguna
      final usersSnapshot = await _firestore.collection('users').get();
      final users = usersSnapshot.docs;

      // Font untuk PDF
      final poppins = await PdfGoogleFonts.poppinsBold();
      final poppinsRegular = await PdfGoogleFonts.poppinsRegular();

      for (var userDoc in users) {
        final userId = userDoc.id;
        final name = userDoc.data()['name'] ?? '-';
        final age = userDoc.data()['age'] ?? '-';
        final gender = userDoc.data()['gender'] ?? '-';


        // Ambil diagnosa terbaru untuk setiap pengguna
        final querySnapshot = await _firestore
            .collection('diagnoses')
            .where('userId', isEqualTo: userId)
            .orderBy('dateCreated', descending: true)
            .limit(1) // Hanya ambil 1 dokumen per pengguna
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final diagnosis = querySnapshot.docs.first.data();
          final diagnosaResult = diagnosis['diagnosisResult'] ?? '-';
          final double totalCf = diagnosis['totalCf'] ?? 0.0;
          final int finalCf = totalCf.round();
          final dateDiagnosis = diagnosis['dateDiagnosis'] ?? '-';

          // Tambahkan diagnosa ke dalam PDF
          pdf.addPage(pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Container(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 17, vertical: 18),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      'IREMIA',
                      style: pw.TextStyle(
                        font: poppins,
                        color: PdfColors.blue,
                        fontSize: 40,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.SizedBox(height: 16),
                    pw.Text(
                      'Hasil Diagnosa',
                      style: pw.TextStyle(
                        font: poppins,
                        color: PdfColors.black,
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.SizedBox(height: 16),

                    // Informasi Pengguna
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _buildUserInfoRow('Nama', name),
                        pw.SizedBox(height: 6),
                        _buildUserInfoRow(
                            'Usia', '$age tahun'),
                        pw.SizedBox(height: 6),
                        _buildUserInfoRow(
                            'Jenis Kelamin', gender),
                      ],
                    ),
                    pw.SizedBox(height: 64),

                    // Tingkat Anxiety
                    pw.Text(
                      'Tingkat Anxiety Kamu',
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 1),
                    // Deskripsi Hasil
                    pw.Text(
                      // Logika Tingkat Anxiety
                      diagnosaResult,
                      style: pw.TextStyle(
                          color: PdfColors.black,
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          font: poppinsRegular),
                      textAlign: pw.TextAlign.center,
                    ),
                    pw.SizedBox(height: 28),
                    // Chart Bar
                    pw.Row(children: [
                      pw.Expanded(
                        child: _buildChartBar(finalCf),
                      )
                    ]),
                    pw.Spacer(),

                    // Nilai CF dan Tanggal
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Nilai CF: $finalCf',
                          style: const pw.TextStyle(
                            fontSize: 12,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.Text(
                          dateDiagnosis,
                          style: const pw.TextStyle(
                            fontSize: 12,
                            color: PdfColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          )
          );
        }
      }
    } catch (e) {
      debugPrint('Error generating PDF: $e');
      throw Exception('Error generating PDF: $e');
    }

    return pdf;
  }
  pw.Widget _buildUserInfoRow(String label, String value) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 3,
          child: pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.Expanded(
          flex: 5,
          child: pw.Text(
            ': $value',
            style: const pw.TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  /// Widget untuk menampilkan chart bar tingkat CF
  pw.Widget _buildChartBar(int cfValue) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Container(
          margin: const pw.EdgeInsets.symmetric(horizontal: 6.5),
          height: 25,
          width: double.infinity,
          child: pw.Center(
            child: pw.Stack(
              fit: pw.StackFit.passthrough,
              overflow: pw.Overflow.visible,
              alignment: pw.Alignment.center,
              children: [
                pw.Container(
                  height: 20,
                  width: double.infinity,
                  decoration: const pw.BoxDecoration(
                    gradient: pw.LinearGradient(
                      colors: [
                        PdfColors.green,
                        PdfColors.yellow,
                        PdfColors.red
                      ],
                    ),
                  ),
                ),
                pw.Positioned(
                  top: -18,
                  left: (cfValue / 63) * 423,
                  child: pw.Column(children: [
                    pw.Text('$cfValue'),
                    pw.Container(
                        width: 10,
                        height: 28,
                        decoration: pw.BoxDecoration(
                            color: PdfColors.white, border: pw.Border.all())),
                  ]),
                ),
              ],
            ),
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Ringan', style: const pw.TextStyle(fontSize: 10)),
            pw.Text('Sedang', style: const pw.TextStyle(fontSize: 10)),
            pw.Text('Berat', style: const pw.TextStyle(fontSize: 10)),
          ],
        ),
      ],
    );
  }
}
