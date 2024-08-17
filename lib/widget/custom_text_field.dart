import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final FocusNode focusNode;
  final bool isPassword;
  final bool? obscureText;
  final TextInputType inputType;
  final VoidCallback? onSuffixTap;

  CustomTextField({
    Key? key,
    required this.controller,
    required this.icon,
    required this.hintText,
    required this.focusNode,
    this.isPassword = false,
    this.obscureText,
    this.inputType = TextInputType.text,
    this.onSuffixTap,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText ?? widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: TextField(
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.black),
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.inputType,
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: Icon(
              widget.icon,
              color: widget.focusNode.hasFocus
                  ? AppColors.secondary
                  : AppColors.grey,
              size: 24.sp,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.grey,
                      size: 24.sp,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                      if (widget.onSuffixTap != null) {
                        widget.onSuffixTap!();
                      }
                    },
                  )
                : null,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide:
                    BorderSide(color: AppColors.secondary, width: 2.w)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide:
                    BorderSide(color: AppColors.secondary, width: 2.w)),
          ),
        ),
      ),
    );
  }
}
