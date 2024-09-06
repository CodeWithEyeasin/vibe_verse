import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';


class ImageListView extends StatelessWidget {
  final List<String> imageUrls;
  const ImageListView({Key? key, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(),
                  const SizedBox(width: 10,),
                  Column(children: [
                    Text('Caption',style: TextStyle(
                      color: Colors.grey.shade600
                    ),),
                    Text('Location',style: TextStyle(
                        color: Colors.grey.shade500,
                      fontSize: 15
                    ),),
                  ],),
                  const Spacer(),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz)),
                ],
              ),
              const SizedBox(height: 10,),

              ClipRRect(
                // borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0),topRight:Radius.circular(10.0)),
                child: Image.network(imageUrls[index]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border, color: AppColors.secondary, size: 30),
                      onPressed: () {
                        // Handle like button press
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.comment, color: AppColors.secondary, size: 30),
                      onPressed: () {
                        // Handle comment button press
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: AppColors.secondary, size: 30),
                      onPressed: () {
                        // Handle share button press
                      },
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border, color: AppColors.secondary, size: 30),
                      onPressed: () {
                        // Handle save button press
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

