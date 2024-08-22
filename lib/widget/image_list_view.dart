import 'package:flutter/material.dart';

class ImageListView extends StatelessWidget {
  final List<String> imageUrls;

  const ImageListView({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(imageUrls[index]),
        );
      },
    );
  }
}