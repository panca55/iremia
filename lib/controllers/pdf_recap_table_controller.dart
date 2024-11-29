import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfRecapTableController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Membuat PDF dengan diagnosa terbaru dari semua pengguna
  Future<pw.Document> createLatestDiagnosesPdfTable(
      BuildContext context) async {
    final pdf = pw.Document();

    try {
      // Ambil semua pengguna
      final usersSnapshot = await _firestore.collection('users').get();
      final users = usersSnapshot.docs;

      // Font untuk PDF
      final poppins = await PdfGoogleFonts.poppinsBold();
      final poppinsRegular = await PdfGoogleFonts.poppinsRegular();

      // List untuk menampung semua row tabel
      List<pw.TableRow> tableRows = [];

      // Tambahkan header tabel
      tableRows.add(
        pw.TableRow(
          children: [
            pw.Text('No', style: pw.TextStyle(font: poppins)),
            pw.Text('Nama', style: pw.TextStyle(font: poppins)),
            pw.Text('Usia', style: pw.TextStyle(font: poppins)),
            pw.Text('Jenis Kelamin', style: pw.TextStyle(font: poppins)),
            pw.Text('Hasil Diagnosa', style: pw.TextStyle(font: poppins)),
            pw.Text('Nilai CF', style: pw.TextStyle(font: poppins)),
            pw.Text('Tanggal Diagnosa', style: pw.TextStyle(font: poppins)),
          ],
        ),
      );

      // Loop melalui semua pengguna dan fetch data diagnosa terbaru
      int index = 0;
      for (var userDoc in users) {
        final userId = userDoc.id;
        final name = userDoc.data()['name'] ?? '-';
        final age = userDoc.data()['age'] ?? '-';
        final role = userDoc.data()['role'] ?? '-';
        final gender = userDoc.data()['gender'] ?? '-';

        if (role == 'user') {
          // Ambil diagnosa terbaru
          final querySnapshot = await _firestore
              .collection('diagnoses')
              .where('userId', isEqualTo: userId)
              .orderBy('dateCreated', descending: true)
              .limit(1)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            final diagnosis = querySnapshot.docs.first.data();
            final diagnosisResult = diagnosis['diagnosisResult'] ?? '-';
            final double totalCf = diagnosis['totalCf'] ?? 0.0;
            final int finalCf = totalCf.round();
            final dateDiagnosis = diagnosis['dateDiagnosis'] ?? '-';

            // Tambahkan data ke dalam tabel
            tableRows.add(
              pw.TableRow(
                children: [
                  pw.Text(' ${++index}',
                      style: pw.TextStyle(font: poppinsRegular)),
                  pw.Text(name, style: pw.TextStyle(font: poppinsRegular)),
                  pw.Text(' $age tahun',
                      style: pw.TextStyle(font: poppinsRegular)),
                  pw.Text(gender, style: pw.TextStyle(font: poppinsRegular)),
                  pw.Text(diagnosisResult,
                      style: pw.TextStyle(font: poppinsRegular)),
                  pw.Text(' $finalCf',
                      style: pw.TextStyle(font: poppinsRegular)),
                  pw.Text(' $dateDiagnosis',
                      style: pw.TextStyle(font: poppinsRegular)),
                ],
              ),
            );
          } else {
            // Jika tidak ada diagnosa, tambahkan data kosong
            tableRows.add(
              pw.TableRow(
                children: [
                  pw.Text('${++index}',
                      style: pw.TextStyle(font: poppinsRegular)),
                  pw.Text(name, style: pw.TextStyle(font: poppinsRegular)),
                  pw.Text('$age tahun',
                      style: pw.TextStyle(font: poppinsRegular)),
                  pw.Text(gender, style: pw.TextStyle(font: poppinsRegular)),
                  pw.Text('-', style: pw.TextStyle(font: poppinsRegular)),
                  pw.Text('-', style: pw.TextStyle(font: poppinsRegular)),
                  pw.Text('-', style: pw.TextStyle(font: poppinsRegular)),
                ],
              ),
            );
          }
        }
      }

      // Tambahkan halaman untuk tabel
      pdf.addPage(
        pw.Page(
          orientation: pw.PageOrientation.landscape,
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Padding(
              padding: const pw.EdgeInsets.all(16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Tabel Hasil Diagnosa Terbaru Semua User',
                    style: pw.TextStyle(
                      font: poppins,
                      fontSize: 16,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.SizedBox(height: 16),
                  pw.Expanded(
                    child: pw.ListView.builder(
                      itemCount: tableRows.length,
                      itemBuilder: (context, i) {
                        return pw.Table(
                          border: pw.TableBorder.all(color: PdfColors.black),
                          columnWidths: {
                            0: const pw.FixedColumnWidth(30),
                            1: const pw.FlexColumnWidth(2),
                            2: const pw.FlexColumnWidth(1),
                            3: const pw.FlexColumnWidth(1.5),
                            4: const pw.FlexColumnWidth(2),
                            5: const pw.FlexColumnWidth(1),
                            6: const pw.FlexColumnWidth(1.5),
                          },
                          children: [tableRows[i]],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    } catch (e) {
      debugPrint('Error generating PDF: $e');
      throw Exception('Error generating PDF: $e');
    }

    return pdf;
  }
}
