// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iremia/controllers/pdf_controller_admin.dart';
import 'package:iremia/provider/question_provider.dart';
import 'package:iremia/theme/global_color_theme.dart';
import 'package:iremia/views/widgets/navbar.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class DiagnoseResultAdmin extends StatelessWidget {
  static String routeName = '/diagnose-result-admin';

  const DiagnoseResultAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<QuestionProvider>(context, listen: false);
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final diagnoseId = arguments['diagnoseId'] as String;
    final userId = arguments['userId'] as String;
    // Instance PDF Controller
    final pdfController = PdfControllerAdmin();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text('Hasil Diagnosa'),
        shadowColor: Colors.black.withOpacity(0.25),
        leading: GestureDetector(
          onTap: ()=> Navigator.of(context).popUntil(ModalRoute.withName(Navbar.routname)),
          child: Container(
            width: 32,
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 7.1, vertical:8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.25), offset: const Offset(0, 4)),
              ]
            ),
            child: const Center(child: Icon(Icons.arrow_back_ios_new, color: Colors.black,size: 16,)),
          ),
        ),  
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download_outlined),
            onPressed: () async {
              try {
                // Generate PDF berdasarkan diagnoseId
                final pdf =
                    await pdfController.createPdfById(context, diagnoseId, userId);
                // Bagikan file PDF
                await Printing.sharePdf(
                  bytes: await pdf.save(),
                  filename: 'Hasil_Diagnosa_$userId.pdf',
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error saat mengunduh PDF: $e')),
                );
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<pw.Document?>(
        future: pdfController.createPdfById(context, diagnoseId, userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(
                child: CircularProgressIndicator(
                  color: GlobalColorTheme.primaryColor,
                ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('Diagnosa tidak ditemukan atau telah dihapus'),
            );
          } else {
            final pdf = snapshot.data!;

            return PdfPreview(
              // pages: [],
              initialPageFormat: PdfPageFormat.a4,
              scrollViewDecoration: const BoxDecoration(color: Colors.white),
              previewPageMargin: const EdgeInsets.only(top: 46,right: 26, left: 26),
              build: (format) => pdf.save(),
              allowPrinting: false,
              allowSharing: false,
              canChangeOrientation: false,
              canChangePageFormat: false,
              canDebug: false,
              onZoomChanged: (value) => true,
            );
          }
        },
      ),
    );
  }
}
