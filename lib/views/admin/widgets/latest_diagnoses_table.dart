import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iremia/provider/latest_diagnoses_provider.dart';
import 'package:iremia/theme/global_color_theme.dart';
import 'package:iremia/views/admin/diagnose_result_admin.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class LatestDiagnosesTable extends StatelessWidget {
  const LatestDiagnosesTable({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<LatestDiagnosesProvider>(context, listen: false)
        .fetchLatestDiagnoses();
    return Container(
      margin: EdgeInsets.zero,
      child: FutureBuilder(
          future: Provider.of<LatestDiagnosesProvider>(context, listen: false)
              .fetchLatestDiagnoses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Terjadi kesalahan: ${snapshot.error}'));
            } else {
              return Consumer<LatestDiagnosesProvider>(
                builder: (context, provider, child) {
                  if (provider.latestDiagnoses.isEmpty) {
                    return const Center(
                        child: Text('Tidak ada data diagnosa tersedia.'));
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('No', style: GoogleFonts.poppins())),
                        DataColumn(label: Text('Nama', style: GoogleFonts.poppins())),
                        DataColumn(label: Text('Usia', style: GoogleFonts.poppins())),
                        DataColumn(label: Text('Jenis Kelamin',
                                style: GoogleFonts.poppins())),
                        DataColumn(label: Text('Hasil Diagnosa',
                                style: GoogleFonts.poppins())),
                        DataColumn(label: Text('Nilai CF', style: GoogleFonts.poppins())),
                        DataColumn(label: Text('Tanggal Diagnosa',
                                style: GoogleFonts.poppins())),
                        DataColumn(label: Text('Aksi', style: GoogleFonts.poppins())),
                      ],
                      rows:
                          provider.latestDiagnoses.asMap().entries.map((entry) {
                        final index = entry.key;
                        final diagnosis = entry.value;
                        final double finalCfDecimal =
                            diagnosis['totalCf'] ?? 0.0;
                        final int finalCfInteger = finalCfDecimal.round();
                        return DataRow(cells: [
                          DataCell(Text('${index + 1}',
                              style: GoogleFonts.poppins())),
                          DataCell(Text(diagnosis['name'],
                              style: GoogleFonts.poppins())),
                          DataCell(Text('${diagnosis['age']} tahun',
                              style: GoogleFonts.poppins())),
                          DataCell(Text(diagnosis['gender'],
                              style: GoogleFonts.poppins())),
                          DataCell(Text(diagnosis['diagnosisResult'],
                              style: GoogleFonts.poppins())),
                          DataCell(Text(finalCfInteger.toString(), style: GoogleFonts.poppins())),
                          DataCell(Text(diagnosis['dateDiagnosis'])),
                          DataCell(
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: GlobalColorTheme.successColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Lihat', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold,),),
                              ),
                              onTap: () {
                                // Navigasi ke halaman DiagnoseResult
                                PersistentNavBarNavigator
                                    .pushNewScreenWithRouteSettings(
                                  context,
                                  settings: RouteSettings(
                                    name: DiagnoseResultAdmin.routeName,
                                    arguments: {
                                      'diagnoseId': diagnosis['diagnosisId'],
                                      'userId': diagnosis['userId'],
                                    },
                                  ),
                                  screen: const DiagnoseResultAdmin(),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
