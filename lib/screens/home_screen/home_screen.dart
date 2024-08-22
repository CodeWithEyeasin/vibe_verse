import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vibe_verse/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Vibe Verse',
          style: GoogleFonts.lobster(
            fontSize: 35.sp,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
        leading: CircleAvatar(
          radius: 10.r,
          backgroundColor: AppColors.white,
          child: Icon(Icons.person, color: AppColors.secondary, size: 20.h),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.message)),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').orderBy('time', descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No posts available'));
            }

            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      var post = snapshot.data!.docs[index];
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
                                    child: Image.network(post['profileImage']),
                                  ),
                                ),
                                title: Text(
                                  post['username'],
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  post['location'],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                trailing: const Icon(Icons.more_horiz),
                              ),
                            ),
                          ),
                          Container(
                            width: 375.w,
                            height: 375.h,
                            child: Image.network(
                              post['postImage'],
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
                                    const Icon(Icons.favorite_border_rounded, size: 30),
                                    SizedBox(width: 17.w),
                                    const Icon(Icons.comment_bank_outlined, size: 30),
                                    SizedBox(width: 17.w),
                                    const Icon(Icons.share_sharp, size: 30),
                                    const Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(right: 15.w),
                                      child: const Icon(Icons.bookmark_border, size: 30),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 24.w),
                                      child: Text(
                                        '${post['like'].length} likes',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Row(
                                    children: [
                                      Text(
                                        post['username'],
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Text(
                                          post['caption'],
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    childCount: snapshot.data!.docs.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
