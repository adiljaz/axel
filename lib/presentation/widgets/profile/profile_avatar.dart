// presentation/widgets/profile/profile_avatar.dart
import 'dart:io';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onTap;
  final double radius;

  const ProfileAvatar({
    super.key,
    this.imagePath,
    required this.onTap,
    this.radius = 60,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          CircleAvatar(
            radius: radius,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            backgroundImage: imagePath != null && imagePath!.isNotEmpty
                ? FileImage(File(imagePath!))
                : null,
            child: imagePath == null || imagePath!.isEmpty
                ? Icon(
                    Icons.person,
                    size: radius,
                    color: Theme.of(context).primaryColor,
                  )
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.camera_alt,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

