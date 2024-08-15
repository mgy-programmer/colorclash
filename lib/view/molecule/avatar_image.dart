import 'dart:io';

import 'package:colorclash/utility/screen_size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarImage extends StatelessWidget {
  final Color bgColor;
  final String imagePath;
  final String selectedAvatar;

  const AvatarImage({super.key, required this.bgColor, required this.imagePath, required this.selectedAvatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSizeUtil().getCalculateWith(context, 45),
      height: ScreenSizeUtil().getCalculateWith(context, 45),
      margin: EdgeInsets.only(
        right: ScreenSizeUtil().getCalculateWith(context, 10),
        bottom: ScreenSizeUtil().getCalculateHeight(context, 17),
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(360),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(360),
        child: Image.file(
          File(selectedAvatar),
          fit: BoxFit.fill,
          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
            return SvgPicture.asset(imagePath);
          },
        ),
      ),
    );
  }
}
