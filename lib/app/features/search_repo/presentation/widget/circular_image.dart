import 'package:flutter/material.dart';

import 'custom_image.dart';


class CircularImage extends StatelessWidget {
  final String imageUrl;
  final double size;
  final Color borderColor;
  const CircularImage({Key? key, required this.imageUrl, required this.size, required this.borderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: borderColor),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: ClipOval(
          child: CustomImage(
        image: imageUrl,
        height: size, width: size, fit: BoxFit.cover,
      )),
    );
  }
}
