import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameBackground extends StatelessWidget {
  final String backgroundImage;
  const GameBackground({super.key, required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SvgPicture.asset(
          backgroundImage,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
