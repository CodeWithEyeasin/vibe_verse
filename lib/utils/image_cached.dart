import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_verse/utils/app_colors.dart';

class CachedImage extends StatelessWidget {
   CachedImage(this.imageURL,{super.key});
  String? imageURL;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imageURL!,
      progressIndicatorBuilder: (context,url,progress){
        return Container(
          child: Padding(
            padding:  EdgeInsets.all(130.h),
            child: CircularProgressIndicator(
              value: progress.progress,
              color: AppColors.black,
            ),
          ),
        );
      },
      errorWidget: (context,url,error)=>Container(
        color: Colors.amber,
      ),
    );
  }
}
