import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:vibe_verse/data/firebase_auth.dart';
import 'package:vibe_verse/screens/auth/splash_screen.dart';
import 'package:vibe_verse/utils/app_colors.dart';
import 'package:vibe_verse/widget/post_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Vibe Verse',
          style: GoogleFonts.lobster(
            fontSize: 35,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
        leading: CircleAvatar(
        radius: 10.r,
          backgroundColor: AppColors.white,
          child: Icon(Icons.person,color: AppColors.secondary,size: 20.h,),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_none),),
          IconButton(onPressed: (){}, icon: const Icon(Icons.message))

        ],
      ),
      body: SafeArea(
        // Center(
        //   child: Text('Home'),
        //   // InkWell(
        //   //     onTap: () async {
        //   //       //logout logic
        //   //       //don't change it
        //   //
        //   //       await Authentication().signOutUser();
        //   //       PersistentNavBarNavigator.pushNewScreen(
        //   //         context,
        //   //         screen: const SplashScreen(),
        //   //         withNavBar: false,
        //   //         pageTransitionAnimation: PageTransitionAnimation.cupertino,
        //   //       );
        //   //     },
        //   //     child: const Text('Home')),
        // ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index){
                return PostWidget();
              },
                childCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
