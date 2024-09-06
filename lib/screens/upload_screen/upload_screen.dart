import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:vibe_verse/screens/post_screen/AddPostScreen.dart';
import 'package:vibe_verse/utils/app_colors.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  List<File> _selectedImages = [];
  int _currentIndex = 0;

  Future<void> _pickImages(ImageSource source) async {
    final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage(
      // Optionally, you can configure the ImagePicker here
    );

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(pickedFiles.map((xfile) => File(xfile.path)).toList());
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  void _onNextPressed() {
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one image')),
      );
      return;
    }

    // Navigate to AddPostScreen with the selected images
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPostScreen(imageFiles: _selectedImages),
      ),
    );
  }

  void _removeImage(File image) {
    setState(() {
      _selectedImages.remove(image);

      // Adjust _currentIndex if necessary
      if (_currentIndex >= _selectedImages.length) {
        _currentIndex = _selectedImages.isNotEmpty ? _selectedImages.length - 1 : 0;
      }
    });
  }

  void _removeAllImages() {
    setState(() {
      _selectedImages.clear();
      _currentIndex = 0; // Reset current index when clearing images
    });
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: _onNextPressed,
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 15, color: AppColors.secondary),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          _buildImagePreview(),
          const Spacer(),
          _buildImagePickerOptions(),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return _selectedImages.isNotEmpty
        ? Column(
      children: [
        CarouselSlider(
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
          items: _selectedImages.map((image) {
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
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        onPressed: () => _removeImage(image),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        DotsIndicator(
          dotsCount: _selectedImages.length,
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
        TextButton(
          onPressed: _removeAllImages,
          child: const Text('Remove All Images'),
        ),
      ],
    )
        : const Center(child: Text('Please select Images'));
  }

  Widget _buildImagePickerOptions() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPickerButton(Icons.image, () => _pickImages(ImageSource.gallery)),
            _buildPickerButton(Icons.camera_alt, _pickImageFromCamera),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text('Images'),
            SizedBox(width: 80),
            Text('Camera'),
            Spacer(),
          ],
        ),
      ],
    );
  }

  Widget _buildPickerButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 120),
    );
  }
}
