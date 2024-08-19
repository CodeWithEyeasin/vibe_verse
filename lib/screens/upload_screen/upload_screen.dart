import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:vibe_verse/utils/app_colors.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final List<Widget> _mediaList = [];
  final List<File> path = [];
  File? _file;
  int currentPage = 0;
  int? lastPage;

  _fetchNewMedia() async {
    lastPage = currentPage;
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<AssetPathEntity> album = await PhotoManager.getAssetPathList(onlyAll: true);
      List<AssetEntity> media = await album[0].getAssetListPaged(page: currentPage, size: 60);

      for (var asset in media) {
        if (asset.type == AssetType.image) {
          final file = await asset.file;
          if (file != null) {
            path.add(File(file.path));
            _file = path[0];
          }
        }
      }

      List<Widget> temp = [];
      for (var asset in media) {
        temp.add(FutureBuilder(
          future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.memory(
                      snapshot.data!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ));
      }

      setState(() {
        _mediaList.addAll(temp);  // Update _mediaList here
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
  }

  int indexx = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          'New Post',
          style: TextStyle(
            color: AppColors.black,
          ),
        ),
        centerTitle: false,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.secondary,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300.h,
                child: _mediaList.isNotEmpty
                    ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                  ),
                  itemCount: _mediaList.length, // Use itemCount
                  itemBuilder: (context, index) {
                    return _mediaList[index];
                  },
                )
                    : const Center(child: CircularProgressIndicator()), // Show loading if list is empty
              ),
              Container(
                width: double.infinity,
                height: 20,
                color: AppColors.white,
                child: Row(
                  children: [
                    // SizedBox(width: 10.w),
                    Text(
                      'Recent',
                      style: TextStyle(
                        fontSize: 15.sh,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              // _mediaList.isNotEmpty
              //     ?
              GridView.builder(
                  shrinkWrap: true,
                  itemCount: _mediaList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            indexx = index;
                          });
                        },
                        child: _mediaList[index]);
                  })
                  // : Container(), // Show nothing if list is empty
            ],
          ),
        ),
      ),
    );
  }
}
