import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_verse/data/firebase_firestore.dart';
import 'package:vibe_verse/data/storage.dart';
import 'package:vibe_verse/utils/app_colors.dart';

class AddPostTextScreen extends StatefulWidget {

   AddPostTextScreen(this._file, {super.key});
  File _file;

  @override
  State<AddPostTextScreen> createState() => _AddPostTextScreenState();
}

class _AddPostTextScreenState extends State<AddPostTextScreen> {
  final caption = TextEditingController();
  final location = TextEditingController();
  bool islooding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.black,
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text('New Post',style: TextStyle(
          color: AppColors.black,
        ),),
        actions: [
          Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal:10.w ),
              child: GestureDetector(
                onTap: () async {
                  if (widget._file == null) {
                    // Handle the case where the file is null
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('No image selected. Please select an image first.'),
                    ));
                    return; // Exit the function early
                  }

                  setState(() {
                    islooding = true;
                  });

                  try {
                    // Upload image to storage and get the URL
                    String? postUrl = await StorageMethod().uploadImageToStorage('post', widget._file);

                    // Check if postUrl is null
                    if (postUrl == null) {
                      throw Exception("Failed to upload image. URL is null.");
                    }

                    // Create the post in Firestore
                    await FirebaseFireStore().createPost(
                      postImage: postUrl,
                      caption: caption.text,
                      location: location.text,
                    );

                    // If everything is successful, pop the page
                    Navigator.of(context).pop();
                  } catch (e) {
                    // If there's an error, log it and show a message
                    print("Error: $e");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Failed to post. Please try again.'),
                    ));
                  } finally {
                    // Ensure loading is set to false regardless of success or failure
                    setState(() {
                      islooding = false;
                    });
                  }
                },

                child: Text('Share',style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 15.sp,
                ),),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child:
          islooding
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColors.black,
                ))
              :
          Padding(
                  padding:  EdgeInsets.only(top: 10.h,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
              child: Row(children: [
                Container(
                  width: 65.w,
                  height: 65.h,
                  decoration: BoxDecoration(color: Colors.amber,
                  image: DecorationImage(image: FileImage(widget._file),fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 10.w,),
                SizedBox(
                  width: 200.w,
                  height: 60.h,
                  child: TextField(
                    controller: caption,
                    decoration: const InputDecoration(
                      hintText: 'Write a caption ...',
                      hintStyle: TextStyle(
                        fontSize: 20,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],),
            ),
            const Divider(),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w),
              child: SizedBox(
                width: 200.w,
                height: 30.h,
                child: TextField(
                  controller: location,
                  decoration: const InputDecoration(
                      hintText: 'Add location',
                    hintStyle: TextStyle(
                      fontSize: 20,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
