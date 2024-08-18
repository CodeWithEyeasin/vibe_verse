import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  child: const Icon(Icons.person_2_outlined),
                ),
              ),
              title: Text('Name',style: TextStyle(
                fontSize: 13.sp,
              ),),
              subtitle: Text('username',style: TextStyle(
                fontSize: 11.sp,
              ),),
              trailing: const Icon(Icons.more_horiz),
            ),
          ),
        ),
        Container(
          width: 375.w,
          height: 375.h,
          child: Image.asset('assets/images/post.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: 375.w,
          color: AppColors.white,
          child: Column(
            children: [
              SizedBox(height: 14.h),
              Row(
                children: [
                  SizedBox(width: 14.w),
                  Icon(Icons.favorite_outline,
                    size: 25.w,
                  ),
                  SizedBox(width: 17.w),
                  Icon(Icons.comment_bank_outlined,size: 25.h,),
                  SizedBox(width: 10.w),
                  Text('20 Comments',style: TextStyle(fontSize: 15.h)),
                  const Spacer(),
                  Padding(
                    padding:  EdgeInsets.only(right: 10.w),
                    child: Icon(Icons.bookmark,size: 28.h,),
                  ),
                ],
              ),
              // Padding(
              //     padding: EdgeInsets.only(
              //         left: 19.w, top: 13.5.h, bottom: 5.h),
              //     child: Text('0',style: TextStyle(
              //     fontSize: 13.sp,
              //     fontWeight: FontWeight.w500,
              //   ),),
              // ),

            ],
          ),
        )
      ],
    );
  }
}
