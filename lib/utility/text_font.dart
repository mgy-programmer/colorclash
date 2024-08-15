import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFont {
  bangersRegularMethod(double size, Color color, {bool isUnderline = false, FontWeight fontWeight = FontWeight.w400}) {
    return GoogleFonts.bangers(
      textStyle: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
        decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }

  alfaRegularMethod(double size, Color color, {bool isUnderline = false, FontWeight fontWeight = FontWeight.w400}) {
    return GoogleFonts.alfaSlabOne(
      textStyle: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
        decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }

  cherryRegularMethod(double size, Color color, {bool isUnderline = false, FontWeight fontWeight = FontWeight.w400}) {
    return GoogleFonts.cherryCreamSoda(
      textStyle: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
        decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
