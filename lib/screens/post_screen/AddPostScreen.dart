import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:vibe_verse/data/firebase_firestore.dart';
import 'package:vibe_verse/utils/app_colors.dart';

class AddPostScreen extends StatefulWidget {
  final List<File> imageFiles; // Pass the selected image files from the previous screen

  const AddPostScreen({super.key, required this.imageFiles});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _isUploading = false;
  int _currentIndex = 0;

  Future<List<String>> _uploadImagesToStorage(List<File> imageFiles) async {
    List<String> imageUrls = [];
    for (File imageFile in imageFiles) {
      String fileName = const Uuid().v4();
      Reference storageReference = FirebaseStorage.instance.ref().child('posts/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
    return imageUrls;
  }

  void _onSharePressed() async {
    String caption = _captionController.text.trim();
    String location = _locationController.text.trim();

    if (caption.isEmpty || location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both caption and location')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // Upload images and get the download URLs
      List<String> imageUrls = await _uploadImagesToStorage(widget.imageFiles);

      // Upload post data to Firestore
      await FirebaseFireStore().createPost(
        postImages: imageUrls,
        caption: caption,
        location: location,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post created successfully')),
      );
      Navigator.pop(context); // Go back to the previous screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create post: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          'New Post',
          style: TextStyle(color: AppColors.black),
        ),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GestureDetector(
                onTap: _isUploading ? null : _onSharePressed,
                child: Text(
                  'Share',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: _isUploading ? AppColors.grey : AppColors.secondary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          // Use SingleChildScrollView to allow scrolling when the keyboard is visible
          child: Column(
            children: [
              SizedBox(
                height: 200.h,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    autoPlay: false,
                    aspectRatio: 16/9,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: widget.imageFiles.map((image) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16.h),
              DotsIndicator(
                dotsCount: widget.imageFiles.length,
                position: _currentIndex.toInt(),
                decorator: DotsDecorator(
                  activeColor: AppColors.secondary,
                  color: Colors.grey,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: _captionController,
                decoration: const InputDecoration(
                  labelText: 'Caption',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.h),
              if (_isUploading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
