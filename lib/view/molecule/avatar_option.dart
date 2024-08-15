import 'package:colorclash/view/atom/designed_button.dart';
import 'package:colorclash/view/molecule/avatar_image.dart';
import 'package:flutter/material.dart';

class AvatarOption extends StatelessWidget {
  final String buttonText;
  final String imagePath;
  final Color bgColor;
  final Color shadowColor;
  final String selectedAvatar;
  final Function() onTap;

  const AvatarOption({super.key, required this.onTap, required this.buttonText, required this.imagePath, required this.bgColor, required this.shadowColor, required this.selectedAvatar});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AvatarImage(bgColor: bgColor, imagePath: imagePath, selectedAvatar: selectedAvatar),
        DesignedButton(
          title: buttonText,
          bgColor: bgColor,
          shadowColor: shadowColor,
          fontSize: 16,
          onTap: onTap,
          width: 160,
        )
      ],
    );
  }
}
