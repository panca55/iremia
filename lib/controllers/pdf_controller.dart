// ignore_for_file: use_build_context_synchronously

import 'package:iremia/controllers/user_controller.dart';
import 'package:iremia/provider/question_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class PdfController extends ChangeNotifier {
  /// Fungsi untuk membuat PDF berdasarkan diagnoseId
  Future<pw.Document> createPdfById(
      BuildContext context, String diagnoseId, String userId) async {
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);

    // Ambil diagnosa dari Firestore berdasarkan diagnoseId
    final diagnosis =
        await questionProvider.getDiagnosisByIdFromFirestore(userId,diagnoseId);

    // Ambil data user
    final userController = Provider.of<UserController>(context, listen: false);
    final user = userController.currentUser;

    if (diagnosis == null) {
      throw Exception('Diagnosa dengan ID $diagnoseId tidak ditemukan.');
    }

    // Nilai CF dari diagnosa
    final double finalCfDesimal = diagnosis.totalCf ?? 0.0;
    final int finalCfInteger = finalCfDesimal ~/ 1;

    // Buat dokumen PDF
    final pdf = pw.Document();
    final poppins = await PdfGoogleFonts.poppinsBold();
    final poppinsRegular = await PdfGoogleFonts.poppinsRegular();

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 17, vertical: 18),
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
                  _buildUserInfoRow('Nama', user?.name ?? '-'),
                  pw.SizedBox(height: 6),
                  _buildUserInfoRow(
                      'Usia', '${user?.usia?.toString() ?? "-"} tahun'),
                  pw.SizedBox(height: 6),
                  _buildUserInfoRow(
                      'Jenis Kelamin', user?.jenisKelamin ?? '-'),
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
                diagnosis.diagnosisResult!,
                style: pw.TextStyle(
                  color: PdfColors.black,
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  font: poppinsRegular
                ),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 28),
              // Chart Bar
              pw.Row(children: [
                pw.Expanded(
                  child: _buildChartBar(finalCfInteger),
                )
              ]),
              pw.Spacer(),

              // Nilai CF dan Tanggal
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Nilai CF: $finalCfInteger',
                    style: const pw.TextStyle(
                      fontSize: 12,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Text(
                    diagnosis.dateDiagnosis!,
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
  pw.Widget _buildChartBar(int cfPercentage) {
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
              alignment:pw.Alignment.center,
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
                  left: (cfPercentage / 100) * 300, // Skala 0-100
                  child: pw.Column(
                    children: [
                      pw.Text('$cfPercentage'),
                      pw.Container(
                        width: 10,
                        height: 28,
                        decoration: pw.BoxDecoration(
                            color: PdfColors.white, border: pw.Border.all())),
                    ]
                  ), 
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
