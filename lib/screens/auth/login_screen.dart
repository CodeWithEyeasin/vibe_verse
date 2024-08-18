import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibe_verse/screens/auth/signup_screen.dart';
import 'package:vibe_verse/screens/persistent_bottom_nav_bar.dart';
import '../../data/firebase_auth.dart';
import '../../utils/app_colors.dart';
import '../../utils/dialog.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTEC = TextEditingController();
  final passwordTEC = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  bool _isLoading = false;
  bool _isEmailFilled = false;
  bool _isPasswordFilled = false;

  @override
  void initState() {
    super.initState();

    emailTEC.addListener(_updateButtonState);
    passwordTEC.addListener(_updateButtonState);

    emailFocus.addListener(() => setState(() {}));
    passwordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailTEC.removeListener(_updateButtonState);
    passwordTEC.removeListener(_updateButtonState);
    emailTEC.dispose();
    passwordTEC.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isEmailFilled = emailTEC.text.isNotEmpty;
      _isPasswordFilled = passwordTEC.text.isNotEmpty;
    });
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Authentication().login(email: emailTEC.text, password: passwordTEC.text);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PersistentBottomNavBar()),
        );
        emailTEC.clear();
        passwordTEC.clear();
      }
    } catch (e) {
      if (mounted) {
        dialogueBuilder(context, e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: ScreenUtil.defaultSize.height * .15.h),
              Text(
                'SociaLive',
                style: GoogleFonts.lobster(
                  textStyle: textTheme.displayLarge,
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 60.h),
              CustomTextField(
                controller: emailTEC,
                icon: Icons.email,
                hintText: 'Email',
                focusNode: emailFocus,
                inputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: passwordTEC,
                icon: Icons.lock,
                hintText: 'Password',
                focusNode: passwordFocus,
                isPassword: true,
                inputType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 48.h),
              CustomButton(
                text: 'Login In',
                onPressed: _handleLogin,
                isEnabled: _isEmailFilled && _isPasswordFilled,
                isLoading: _isLoading,
                disabledColor: AppColors.paleBlue,
                loadingColor: AppColors.secondary,
              ),
              const Spacer(),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: " Don't have an Account? ",
                    style: textTheme.bodySmall?.copyWith(color: AppColors.black),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: textTheme.bodySmall?.copyWith(color: AppColors.secondary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const SignUpScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



