import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iremia/controllers/user_controller.dart';
import 'package:iremia/theme/global_color_theme.dart';
import 'package:iremia/views/edit_profile_page.dart';
import 'package:iremia/views/login_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'IREMIA',
                style: GoogleFonts.poppins(
                    color: const Color(0xFF40BFFF),
                    fontSize: 33,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            Center(
                child: Text(
              'Nama Pengguna',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 62,
            ),
            GestureDetector(
              onTap: (){
                PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                  context,
                  settings: const RouteSettings(name: EditProfilePage.routname),
                  screen: const EditProfilePage(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 21, vertical: 19),
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit data pengguna',
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight/1.9,
            ),
            GestureDetector(
              onTap: (){
                final userController =
                    Provider.of<UserController>(context, listen: false);
                userController.logoutUser();
                PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                  context,
                  settings: const RouteSettings(name: LoginPage.routname),
                  screen: const LoginPage(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.scale,
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 38, vertical: 7.8),
                height: 33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: GlobalColorTheme.errorColor,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Text(
                  'Keluar',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
