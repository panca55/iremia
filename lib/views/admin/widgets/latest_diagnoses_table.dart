import 'package:flutter/material.dart';
import 'package:iremia/provider/latest_diagnoses_provider.dart';
import 'package:iremia/views/admin/diagnose_result_admin.dart';
import 'package:provider/provider.dart';
class LatestDiagnosesTable extends StatelessWidget {
  const LatestDiagnosesTable({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<LatestDiagnosesProvider>(context, listen: false).fetchLatestDiagnoses();
    return Container(
      margin: EdgeInsets.zero,
      child: FutureBuilder(
        future: Provider.of<LatestDiagnosesProvider>(context, listen: false).fetchLatestDiagnoses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Terjadi kesalahan: ${snapshot.error}'));
            }
          else{
          return Consumer<LatestDiagnosesProvider>(
            builder: (context, provider, child) {
              if (provider.latestDiagnoses.isEmpty) {
                return const Center(
                    child: Text('Tidak ada data diagnosa tersedia.'));
              }
          
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('No')),
                    DataColumn(label: Text('Nama')),
                    DataColumn(label: Text('Usia')),
                    DataColumn(label: Text('Jenis Kelamin')),
                    DataColumn(label: Text('Hasil Diagnosa')),
                    DataColumn(label: Text('Nilai CF')),
                    DataColumn(label: Text('Tanggal Diagnosa')),
                    DataColumn(label: Text('Aksi')),
                  ],
                  rows:provider.latestDiagnoses.asMap().entries.map((entry) {
                    final index = entry.key;
                    final diagnosis = entry.value;
                    return DataRow(cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text(diagnosis['name'])),
                      DataCell(Text('${diagnosis['age']}')),
                      DataCell(Text(diagnosis['gender'])),
                      DataCell(Text(diagnosis['diagnosisResult'])),
                      DataCell(Text('${diagnosis['totalCf']}')),
                      DataCell(Text(diagnosis['dateDiagnosis'])),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            // Navigasi ke halaman DiagnoseResult
                            Navigator.pushNamed(
                              context,
                              DiagnoseResultAdmin.routeName,
                                  arguments: {
                                    'diagnoseId': diagnosis['diagnosisId'],
                                    'userId': diagnosis['userId'],
                                  }, // Kirim diagnosisId
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
        }
      ),
    );
  }
}
