import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_verse/utils/image_cached.dart';
import '../utils/app_colors.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.snapshort});

  final Map<String, dynamic> snapshort;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // User Information (Profile Picture, Username, Location)
        Container(
          width: 375.w,
          height: 54.h,
          color: AppColors.white,
          child: Center(
            child: ListTile(
              leading: ClipOval(
                child: SizedBox(
                  width: 35.w,
                  height: 35.h,
                  child: CachedImage(snapshort['profileImage']),
                ),
              ),
              title: Text(
                snapshort['username'],
                style: TextStyle(
                  fontSize: 13.sp,
                ),
              ),
              subtitle: Text(
                snapshort['location'],
                style: TextStyle(
                  fontSize: 11.sp,
                ),
              ),
              trailing: const Icon(Icons.more_horiz),
            ),
          ),
        ),
        // Post Image
        Container(
          width: 375.w,
          height: 375.h,
          child: CachedImage(snapshort['postImage']),
        ),
        // Post Actions (Like, Comment, Bookmark)
        Container(
          width: 375.w,
          color: AppColors.white,
          child: Column(
            children: [
              SizedBox(height: 14.h),
              Row(
                children: [
                  SizedBox(width: 14.w),
                  Icon(
                    Icons.favorite_outline,
                    size: 25.w,
                  ),
                  SizedBox(width: 17.w),
                  Icon(Icons.comment_bank_outlined, size: 25.h),
                  SizedBox(width: 10.w),
                  Text(
                    snapshort['like'].length.toString(),
                    style: TextStyle(fontSize: 15.h),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Icon(
                      Icons.bookmark,
                      size: 28.h,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
