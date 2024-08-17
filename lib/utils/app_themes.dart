import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static final TextTheme lightTextTheme = TextTheme(
    titleLarge: TextStyle(fontSize: 32.sp,fontWeight: FontWeight.w700,color: Colors.black),
    titleMedium: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w600,color: Colors.black),
    titleSmall: TextStyle(fontSize:16.sp, fontWeight: FontWeight.bold,color: Colors.white),

    bodyMedium: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w600),

    labelSmall: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w600)
  );

  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Roboto',
    textTheme: lightTextTheme,
  );
}
