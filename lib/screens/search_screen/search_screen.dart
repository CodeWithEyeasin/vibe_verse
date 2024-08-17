import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Search Screen',
            style: textTheme.titleLarge?.copyWith(color: AppColors.secondary),
          ),
        ),
      ),
    );
  }
}
