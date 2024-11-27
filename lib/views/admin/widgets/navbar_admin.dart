import 'package:flutter/material.dart';
import 'package:iremia/config/navigator_historypage.dart';
import 'package:iremia/config/navigator_homepage.dart';
import 'package:iremia/config/navigator_profilepage.dart';
import 'package:iremia/theme/global_color_theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavbarAdmin extends StatelessWidget {
  static const routname = '/navbar-admin';
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  NavbarAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        navBarHeight: 75,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(context),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        stateManagement: true,
        animationSettings: const NavBarAnimationSettings(
            navBarItemAnimation: ItemAnimationSettings(
                curve: Curves.bounceOut,
                duration: Duration(milliseconds: 500))),
        hideNavigationBarWhenKeyboardAppears: true,
        navBarStyle: NavBarStyle.style3,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
            ),
          ]
          ),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const NavigatorHomepage(),
      const NavigatorHistorypage(),
      const NavigatorProfilepage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home, color: GlobalColorTheme.primaryColor),
        title: 'Beranda',
        activeColorSecondary: GlobalColorTheme.primaryColor,
        activeColorPrimary: GlobalColorTheme.primaryColor,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.grey,
        inactiveIcon: const Icon(
          Icons.home_outlined,
          color: Colors.grey,
        ),
      ),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.history, color: GlobalColorTheme.primaryColor),
          title: 'Riwayat',
          activeColorSecondary: GlobalColorTheme.primaryColor,
          activeColorPrimary: GlobalColorTheme.primaryColor,
          inactiveColorPrimary: Colors.grey,
          inactiveColorSecondary: Colors.grey,
          inactiveIcon: const Icon(
            Icons.history,
            color: Colors.grey,
          )),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.person_2,
            color: GlobalColorTheme.primaryColor,
          ),
          title: 'Profil',
          activeColorSecondary: GlobalColorTheme.primaryColor,
          activeColorPrimary: GlobalColorTheme.primaryColor,
          inactiveColorPrimary: Colors.grey,
          inactiveColorSecondary: Colors.grey,
          inactiveIcon: const Icon(
            Icons.person_2_outlined,
            color: Colors.grey,
          )),
    ];
  }
}
