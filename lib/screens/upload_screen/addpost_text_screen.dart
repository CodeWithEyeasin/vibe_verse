import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_verse/data/firebase_firestore.dart';
import 'package:vibe_verse/data/storage.dart';
import 'package:vibe_verse/utils/app_colors.dart';

class AddPostTextScreen extends StatefulWidget {
  final File file;

  AddPostTextScreen(this.file, {super.key});

  @override
  State<AddPostTextScreen> createState() => _AddPostTextScreenState();
}

class _AddPostTextScreenState extends State<AddPostTextScreen> {
  final TextEditingController captionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.black,
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          'New Post',
          style: TextStyle(
            color: AppColors.black,
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GestureDetector(
                onTap: _handleShare,
                child: Text(
                  'Share',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(
            color: AppColors.black,
          ),
        )
            : Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Row(
                  children: [
                    _buildImagePreview(),
                    SizedBox(width: 10.w),
                    _buildCaptionInput(),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: _buildLocationInput(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      width: 65.w,
      height: 65.h,
      decoration: BoxDecoration(
        color: Colors.amber,
        image: DecorationImage(
          image: FileImage(widget.file),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCaptionInput() {
    return SizedBox(
      width: 200.w,
      height: 60.h,
      child: TextField(
        controller: captionController,
        decoration: const InputDecoration(
          hintText: 'Write a caption ...',
          hintStyle: TextStyle(
            fontSize: 20,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildLocationInput() {
    return SizedBox(
      width: 200.w,
      height: 30.h,
      child: TextField(
        controller: locationController,
        decoration: const InputDecoration(
          hintText: 'Add location',
          hintStyle: TextStyle(
            fontSize: 20,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Future<void> _handleShare() async {
    if (widget.file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No image selected. Please select an image first.'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      String? postUrl = await StorageMethod().uploadImageToStorage('post', widget.file);
      if (postUrl == null) {
        throw Exception("Failed to upload image. URL is null.");
      }

      await FirebaseFireStore().createPost(
        postImage: postUrl,
        caption: captionController.text,
        location: locationController.text,
      );

      Navigator.of(context).pop();
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to post. Please try again.'),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
