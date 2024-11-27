import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iremia/provider/question_provider.dart';
import 'package:iremia/views/diagnose_result.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class UsersDiagnoseHistory extends StatelessWidget {
  static String routename = '/user-diagnose-history';
  final String? userId;
  const UsersDiagnoseHistory({super.key, this.userId});

  @override
  Widget build(BuildContext context) {

    Provider.of<QuestionProvider>(context, listen: false)
            .getDiagnosisByIdFromFirestore(userId!);
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
                  future: Provider.of<QuestionProvider>(context, listen: false).getHistoryDiagnosis(userId!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Terjadi kesalahan: ${snapshot.error}'));
                    }else{
                    return Consumer<QuestionProvider>(
                      builder: (context, diagnosisProvider, child) {
                        final diagnosis = diagnosisProvider.diagnose;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 95),
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.25),
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
                                        Text('Diagnosa ${index+1}',
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                        GestureDetector(
                                          onTap: () {
                                            PersistentNavBarNavigator
                                                  .pushNewScreenWithRouteSettings(
                                                context,
                                                settings: RouteSettings(
                                                name: DiagnoseResult
                                                        .routeName, arguments: diagnosis[index]
                                                            .diagnosisId ??
                                                        '' ),
                                                screen:  const DiagnoseResult(),
                                                withNavBar: false,
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .cupertino,
                                              );
                                          },
                                          child: Container(
                                            width: 82,
                                            height: 27,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.25),
                                                      offset: const Offset(0, 4),
                                                      blurRadius: 10)
                                                ]),
                                            child: Center(
                                                child: Text(
                                              'Lihat',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            )),
                                          ),
                                        )
                                      ],
                                    ));
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
