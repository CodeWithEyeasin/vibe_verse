import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../data/firebase_auth.dart';
import '../auth/splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(onPressed: ()async {

    //logout logic
    await Authentication().signOutUser();
    PersistentNavBarNavigator.pushNewScreen(
    context,
    screen: const SplashScreen(),
    withNavBar: false,
    pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
    }, icon: Icon(Icons.logout_outlined,size: 25.h,))
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Text('Profile')
        ),
      ),
    );
  }
}
