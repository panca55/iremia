import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iremia/controllers/user_controller.dart';
import 'package:iremia/theme/global_color_theme.dart';
import 'package:iremia/views/admin/diagnose_result_all.dart';
import 'package:iremia/views/admin/diagnose_result_table.dart';
import 'package:iremia/views/admin/users_diagnose_history.dart';
import 'package:iremia/views/admin/widgets/latest_diagnoses_table.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatelessWidget {
  static String routename = '/admin-home-page';
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context){
    Provider.of<UserController>(context, listen: false).getUser();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'IREMIA',
                  style: GoogleFonts.poppins(
                      color: const Color(0xFF40BFFF),
                      fontSize: 33,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rekap Diagnosa Terakhir Semua User',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: (){
                    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                      context,
                      settings: RouteSettings(
                          name: DiagnoseResultTable.routeName),
                      screen: const DiagnoseResultTable(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: GlobalColorTheme.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(0, 4))
                        ]),
                    child: Row(
                      children: [
                        const Icon(Icons.download_sharp, size: 12, color: Colors.white,),
                        Text('UNDUH', style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            const LatestDiagnosesTable(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'List User',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                      context,
                      settings:
                          RouteSettings(name: DiagnoseResultAll.routeName),
                      screen: const DiagnoseResultAll(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: GlobalColorTheme.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(0, 4))
                        ]),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.download_sharp,
                          size: 12,
                          color: Colors.white,
                        ),
                        Text('UNDUH',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                  future: Provider.of<UserController>(context, listen: false)
                      .getUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Terjadi kesalahan: ${snapshot.error}'));
                    } else {
                      return Consumer<UserController>(
                        builder: (context, userProvier, child) {
                          final users = userProvier.users;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 95),
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  if (users[index].role == 'user') {
                                  return Container(
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
                                          Text('${users[index].name}',
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
                                                    name: UsersDiagnoseHistory
                                                        .routename,
                                                    arguments: users[index]
                                                            .userId ??
                                                        ''),
                                                screen: UsersDiagnoseHistory(userId: users[index].userId),
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
                                                        offset:
                                                            const Offset(0, 4),
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
                                    
                                  }
                                  return null;
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 14,
                                    ),
                                itemCount: users.length),
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
