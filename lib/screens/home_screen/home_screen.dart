import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibe_verse/utils/app_colors.dart';
import '../../data/firebase_firestore.dart';
import '../../widget/image_list_view.dart';

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
      body:  StreamBuilder<List<String>>(
        stream: FirebaseFireStore().fetchImagesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No images found.'));
          } else {
            return ImageListView(imageUrls: snapshot.data!);
          }
        },
      ),
    );
  }
}
