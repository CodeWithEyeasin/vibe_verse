import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vibe_verse/utils/app_colors.dart';
import 'package:uuid/uuid.dart';

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

  Future<String> _uploadImageToStorage(File imageFile) async {
    String fileName = const Uuid().v4();
    Reference storageReference = FirebaseStorage.instance.ref().child('posts/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void _onNextPressed() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first')),
      );
      return;
    }

    try {
      String imageUrl = await _uploadImageToStorage(_selectedImage!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
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
                    'Share',
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
