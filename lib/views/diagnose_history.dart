import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iremia/provider/question_provider.dart';
import 'package:iremia/theme/global_color_theme.dart';
import 'package:iremia/views/diagnose_result.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class DiagnoseHistory extends StatelessWidget {
  static String routename = '/diagnose-history';
  const DiagnoseHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser;
    final currentUser = userId?.uid;

    Provider.of<QuestionProvider>(context, listen: false)
        .getDiagnosisByIdFromFirestore(currentUser!);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Riwayat Diagnosa',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            const SizedBox(
              height: 14,
            ),
            Expanded(
              child: FutureBuilder(
                  future: Provider.of<QuestionProvider>(context, listen: false)
                      .getHistoryDiagnosis(currentUser),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Terjadi kesalahan: ${snapshot.error}'));
                    } else {
                      return Consumer<QuestionProvider>(
                        builder: (context, diagnosisProvider, child) {
                          final diagnosis = diagnosisProvider.diagnose;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 95),
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      PersistentNavBarNavigator
                                          .pushNewScreenWithRouteSettings(
                                        context,
                                        settings: RouteSettings(
                                            name: DiagnoseResult.routeName,
                                            arguments:
                                                diagnosis[index].diagnosisId ??
                                                    ''),
                                        screen: const DiagnoseResult(),
                                        withNavBar: false,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 10)
                                            ],
                                            gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFF40BFFF),
                                                  Color(0xFF56CCF2),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    diagnosisProvider
                                                        .deleteDiagnosis(
                                                            diagnosis[index]
                                                                .diagnosisId!);
                                                  },
                                                  child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4,
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: GlobalColorTheme
                                                            .errorColor,
                                                        border: Border.all(
                                                          width: 0.2,
                                                          color: Colors.black,
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            offset:
                                                                const Offset(
                                                                    0, 4),
                                                            blurRadius: 4,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.25),
                                                          )
                                                        ],
                                                      ),
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                                const SizedBox(width: 10),
                                                Text('Diagnosa ${diagnosis[index].dateDiagnosis}',
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_outlined, color:Colors.white
                                            )
                                          ],
                                        )),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 14,
                                    ),
                                itemCount: diagnosis.length),
                          );
                        },
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
