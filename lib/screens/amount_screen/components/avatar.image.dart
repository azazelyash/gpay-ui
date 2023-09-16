import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  const AvatarImage({
    super.key,
    required this.urlPath,
  });

  final String urlPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image(
        fit: BoxFit.cover,
        image: AssetImage(urlPath),
        height: 56,
        width: 56,
      ),
    );
  }
}
