import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color loadingColor;
  final Color disabledColor;
  final double borderRadius;
  final bool isEnabled;
  final bool isLoading;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.loadingColor = Colors.white,
    this.disabledColor = Colors.grey,
    this.borderRadius = 8.0,
    this.isEnabled = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil.defaultSize.height * .08.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isLoading
              ? loadingColor
              : (isEnabled ? color : disabledColor), // Use disabledColor if not enabled
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 32.w,
          ),
        ),
        child: isLoading
            ? CircularProgressIndicator(color: loadingColor)
            : Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
