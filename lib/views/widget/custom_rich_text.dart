
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.spans,
    this.textAlign,
    this.visible = true,
    this.margin = EdgeInsets.zero,
  });

  final List<MyTextSpan> spans;
  final TextAlign? textAlign;
  final bool visible;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: Text.rich(
          TextSpan(
            children: spans.map((span) => span.toTextSpan()).toList(),
          ),
          textAlign: textAlign,
        ),
      ),
    );
  }
}

/// Model ----------------------------------------------------------------------
class MyTextSpan {
  final String text;
  final bool isCustomFont;
  final Color color;
  final double fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final VoidCallback? onTap;

  MyTextSpan({
    required this.text,
    this.isCustomFont = true,
    this.color = Colors.black,
    this.fontSize = 13,
    this.fontWeight,
    this.fontStyle,
    this.fontFamily,
    this.decoration,
    this.decorationColor,
    this.onTap
  });

  TextSpan toTextSpan() => TextSpan(
    text: text,
    style: isCustomFont
        ? GoogleFonts.poppins(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight ?? FontWeight.normal,
            fontStyle: fontStyle,
            decoration: decoration,
            decorationColor: decorationColor,
          )
        : TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight ?? FontWeight.normal,
            fontStyle: fontStyle,
            fontFamily: fontFamily,
            decoration: decoration,
            decorationColor: decorationColor,
          ),
    recognizer: onTap != null
        ? (TapGestureRecognizer()..onTap = onTap)
        : null,
  );
}


