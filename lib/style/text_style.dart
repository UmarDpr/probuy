
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'common_colors.dart';

TextStyle body1(Color color,FontWeight fontWeight) => GoogleFonts.lato(
    textStyle:  TextStyle(
      letterSpacing: 0.5,
      color: color,
      fontSize: 12,
      fontWeight: fontWeight,
    )
);

TextStyle body2(Color color,FontWeight fontWeight) => GoogleFonts.lato(
    textStyle:  TextStyle(
      letterSpacing: 0.5,
      color: color,
      fontSize: 14,
      fontWeight: fontWeight,
    )
);

TextStyle body3(Color color,FontWeight fontWeight) => GoogleFonts.lato(
    textStyle:  TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: fontWeight,
      letterSpacing: 0.5

    )
);

TextStyle body4(Color color,FontWeight fontWeight) => GoogleFonts.lato(
    textStyle:  TextStyle(
      color: color,
      fontSize: 18,
      fontWeight: fontWeight,
      letterSpacing: 0.5

    )
);

TextStyle body5(Color color,FontWeight fontWeight) => GoogleFonts.lato(
    textStyle:  TextStyle(
      color: color,
      fontSize: 20,
      fontWeight: fontWeight,
      letterSpacing: 0.5
    )
);

TextStyle underLineTxt(Color color,FontWeight fontWeight,double size) => GoogleFonts.lato(
    textStyle:   TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
        decoration: TextDecoration
            .lineThrough)
);


TextStyle heading1(Color color,FontWeight fontWeight) => GoogleFonts.lato(
    textStyle:  TextStyle(
      color: color,
      fontSize: 22,
      fontWeight: fontWeight,
      letterSpacing: 0.5
    )
);

TextStyle heading2(Color color,FontWeight fontWeight) => GoogleFonts.lato(
    textStyle:  TextStyle(
      color: color,
      fontSize: 24,
      fontWeight: fontWeight,
      letterSpacing: 0.5
    )
);

TextStyle heading3(Color color,FontWeight fontWeight) => GoogleFonts.lato(
    textStyle:  TextStyle(
      color: color,
      fontSize: 26,
      fontWeight: fontWeight,
      letterSpacing: 0.5
    )
);

TextStyle heading4(Color color,FontWeight fontWeight) => GoogleFonts.lato(
    textStyle:  TextStyle(
      color: color,
      fontSize: 28,
      fontWeight: fontWeight,
      letterSpacing: 0.5
    )
);

TextStyle heading5(Color color,FontWeight fontWeight) => GoogleFonts.lato(
    textStyle:  TextStyle(
      color: color,
      fontSize: 30,
      fontWeight: fontWeight,
      letterSpacing: 0.5
    )
);

InputDecoration textFieldDecoration(String? label) {
  return InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    fillColor: Colors.grey.shade50,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    hoverColor: primaryLight,
    focusColor: secondary,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    filled: true,
    hintStyle: TextStyle(
        letterSpacing: 0.6,
        color: Colors.grey.shade400,
        fontSize: 15,
        fontWeight: FontWeight.w400),
    hintText: label,
  );
}

