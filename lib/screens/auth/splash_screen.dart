import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vibe_verse/screens/auth/landing_screen.dart';
import 'package:vibe_verse/screens/persistent_bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      if(mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PersistentBottomNavBar()));
      }
    } else {
      if(mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LandingScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'SociaLive',
            style: GoogleFonts.lobster(
              textStyle: Theme.of(context).textTheme.displayLarge,
              fontSize: 48,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          )
              .animate()
              .fadeIn(duration: 1500.ms, curve: Curves.easeIn)
              .then()
              .scale(duration: 1000.ms, curve: Curves.easeOut, begin: Offset(0.8, 0.8), end: Offset(1.0, 1.0))
              .then(delay: 500.ms)
              .fadeOut(duration: 2.seconds,curve: Curves.easeInOut)
        ),
      ),
    );
  }
}
