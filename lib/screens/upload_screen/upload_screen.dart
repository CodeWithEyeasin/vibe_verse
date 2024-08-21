import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vibe_verse/utils/app_colors.dart';

import 'addpost_text_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _onNextPressed() {
    if (_selectedImage != null) {
      // Add your navigation logic here
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddPostTextScreen(_selectedImage!),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          'New Post',
          style: TextStyle(color: AppColors.black),
        ),
        centerTitle: false,
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GestureDetector(
                onTap: _onNextPressed,
                child: InkWell(
                  onTap: _onNextPressed,
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 15.sp, color: AppColors.secondary),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          _buildImagePreview(),
          SizedBox(height: 10.h),
          _buildImagePickerOptions(),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      height: 300.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        image: _selectedImage != null
            ? DecorationImage(
          image: FileImage(_selectedImage!),
          fit: BoxFit.cover,
        )
            : null,
      ),
      child: _selectedImage == null
          ? const Center(
        child: Text('Please select an Image'),
      )
          : null,
    );
  }

  Widget _buildImagePickerOptions() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPickerButton(Icons.image, () => _pickImage(ImageSource.gallery)),
            _buildPickerButton(Icons.camera_alt_rounded, () => _pickImage(ImageSource.camera)),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Images'),
            SizedBox(width: 75),
            Text('Camera'),
          ],
        ),
      ],
    );
  }

  Widget _buildPickerButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 120),
    );
  }
}
