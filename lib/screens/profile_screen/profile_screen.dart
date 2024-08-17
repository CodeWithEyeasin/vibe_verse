import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

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
      body: SafeArea(
        child: Center(
          child: Text(
            'Profile Screen',
            style: textTheme.titleLarge?.copyWith(color: AppColors.secondary),
          ),
        ),
      ),
    );
  }
}
