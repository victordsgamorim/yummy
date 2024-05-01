import 'package:flutter/material.dart';
import 'package:yummy_app/core/utils/extensions/context_extension.dart';

class ProfileAvatar extends StatelessWidget {
  final VoidCallback onTap;
  final ImageProvider image;

  const ProfileAvatar({
    super.key,
    required this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: context.colorScheme.onPrimaryContainer,
            width: 3,
          ),
          // image: DecorationImage(
          //   fit: BoxFit.cover,
          //   image: image,
          // ),
        ),
      ),
    );
  }
}
