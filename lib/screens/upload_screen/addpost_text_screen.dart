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
                  setState(() {
                    islooding = true;
                  });
                  String post_url = await StorageMethod()
                      .uploadImageToStorage('post', widget._file);
                  await FirebaseFireStore().createPost(
                      postImage: post_url,
                      caption: caption.text,
                      location: location.text);
                  setState(() {
                    islooding = false;
                  });
                  Navigator.of(context).pop();
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
