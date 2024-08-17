import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:vibe_verse/screens/home_screen/home_screen.dart';
import 'package:vibe_verse/screens/profile_screen/profile_screen.dart';
import 'package:vibe_verse/screens/search_screen/search_screen.dart';
import 'package:vibe_verse/screens/upload_screen/upload_screen.dart';



class PersistentBottomNavBar extends StatefulWidget {
  const PersistentBottomNavBar({super.key});

  @override
  _PersistentBottomNavBarState createState() => _PersistentBottomNavBarState();
}

class _PersistentBottomNavBarState extends State<PersistentBottomNavBar> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return const [
      HomeScreen(),
      SearchScreen(),
      UploadScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home,
            color: _controller.index == 0 ? Colors.blue : Colors.black),
        title: "HOME",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search,
            color: _controller.index == 1 ? Colors.blue : Colors.black),
        title: "Search",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add,
            color: _controller.index == 2 ? Colors.blue : Colors.black),
        title: "Upload",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person,
            color: _controller.index == 3 ? Colors.blue : Colors.black),
        title: "Profile",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineToSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardAppears: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0.r),
          colorBehindNavBar: Colors.white,
        ),
        isVisible: true,
        navBarHeight: kBottomNavigationBarHeight + 10.h, // Adjusting height to prevent overflow
        navBarStyle: NavBarStyle.style9,
        padding: EdgeInsets.only(bottom: 8.h, top: 8.h),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h), // Adjusting margin
        animationSettings: const NavBarAnimationSettings(
          navBarItemAnimation: ItemAnimationSettings(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimationSettings(
            animateTabTransition: true,
            duration: Duration(milliseconds: 200),
            screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
          ),
        ),
      ),
    );
  }
}

