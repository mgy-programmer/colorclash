import 'package:colorclash/utility/screen_size_util.dart';
import 'package:colorclash/view/atom/designed_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ColorOption extends StatelessWidget {
  final String buttonText;
  final String imagePath;
  final Color bgColor;
  final Color shadowColor;
  final Color selectedColor;
  final Function() onTap;

  const ColorOption({super.key, required this.onTap, required this.buttonText, required this.imagePath, required this.bgColor, required this.shadowColor, required this.selectedColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: ScreenSizeUtil().getCalculateWith(context, 45),
          height: ScreenSizeUtil().getCalculateWith(context, 45),
          margin: EdgeInsets.only(
            right: ScreenSizeUtil().getCalculateWith(context, 10),
            bottom: ScreenSizeUtil().getCalculateHeight(context, 17),
          ),
          decoration: BoxDecoration(
            color: selectedColor,
            borderRadius: BorderRadius.circular(360),
          ),
          child: Center(
            child: SvgPicture.asset(imagePath),
          ),
        ),
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
