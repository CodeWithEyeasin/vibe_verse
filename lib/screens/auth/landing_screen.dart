import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibe_verse/screens/auth/login_screen.dart';
import 'package:vibe_verse/screens/auth/signup_screen.dart';
import 'package:vibe_verse/utils/app_colors.dart';
import '../../widget/custom_button.dart';
import 'package:flutter_animate/flutter_animate.dart';


class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              // Staggered Text Animation for the Title
              Text(
                'Vibe Verse',
                style: GoogleFonts.lobster(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 48.sp,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              )
                  .animate()
                  .fadeIn(duration: 1.seconds, curve: Curves.easeIn)
                  .then(delay: 200.ms)
                  .scale(duration: 800.ms, curve: Curves.easeOut)
                  .slideY(duration: 800.ms, curve: Curves.easeInOut, begin: 0.5, end: 0.0)
                  .shimmer(duration: 1.seconds, angle: 90, color: Colors.blue),

              SizedBox(height: ScreenUtil.defaultSize.height * .1.h),

              // Sliding Button Animation from Bottom
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 0.h),
                child: CustomButton(
                  text: 'Create Account',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                )
                    .animate()
                    .slideY(duration: 1.seconds, curve: Curves.easeOut, begin: 0.3, end: 0.0)
                    .then(delay: 200.ms)
                    .fadeIn(duration: 800.ms),
              ),

              SizedBox(height: 16.h),

              // Rotating and Sliding Text Button Animation
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Animate the "Log In" text with a gentle rotation and scale
                    Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                        .animate()
                        .rotate(
                      begin: 0.0,
                      end: 0.05, // Slight forward rotation
                      duration: 800.ms, // Extended duration
                      curve: Curves.easeInOut,
                    )
                        .then() // Continue to oscillate and then settle straight
                        .rotate(
                      begin: 0.05,
                      end: -0.03, // Slight backward rotation
                      duration: 600.ms,
                      curve: Curves.easeInOut,
                    )
                        .then()
                        .rotate(
                      begin: -0.03,
                      end: 0.0, // Settle to straight position
                      duration: 500.ms,
                      curve: Curves.easeInOut,
                    )
                        .scale(duration: 600.ms, curve: Curves.fastOutSlowIn)
                        .slideX(
                      begin: 0.5,
                      end: 0.0,
                      duration: 1000.ms, // Extended slide duration
                      curve: Curves.easeOut,
                    ),

                    // Animate the Icon with a similar, but mirrored effect
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.secondary,
                      size: 24.sp,
                    )
                        .animate()
                        .rotate(
                      begin: 0.0,
                      end: -0.05, // Slight backward rotation
                      duration: 800.ms, // Extended duration
                      curve: Curves.easeInOut,
                    )
                        .then() // Continue to oscillate and then settle straight
                        .rotate(
                      begin: -0.05,
                      end: 0.03, // Slight forward rotation
                      duration: 600.ms,
                      curve: Curves.easeInOut,
                    )
                        .then()
                        .rotate(
                      begin: 0.03,
                      end: 0.0, // Settle to straight position
                      duration: 500.ms,
                      curve: Curves.easeInOut,
                    )
                        .scale(duration: 600.ms, curve: Curves.fastOutSlowIn)
                        .slideX(
                      begin: -0.5,
                      end: 0.0,
                      duration: 1000.ms, // Extended slide duration
                      curve: Curves.easeOut,
                    ),
                  ],
                ),
              ),


              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}


