import 'package:flutter/material.dart';
import 'package:vibe_verse/utils/app_colors.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Upload Screen',
            style: textTheme.titleLarge?.copyWith(color: AppColors.secondary),
          ),
        ),
      ),
    );
  }
}
