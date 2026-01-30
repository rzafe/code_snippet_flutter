
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextResize extends StatelessWidget {
  final String title;
  final Color? textColor;
  final double? fontSize;
  final double minFontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool isCustomFont;
  final bool wrapWords;
  final bool visible;
  final EdgeInsets margin;
  final Function()? onTap;

  const CustomTextResize({
    super.key,
    required this.title,
    this.textColor,
    this.fontSize,
    this.minFontSize = 12,
    this.fontWeight,
    this.fontStyle,
    this.fontFamily,
    this.decoration,
    this.decorationColor,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.isCustomFont = true,
    this.wrapWords = true,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: GestureDetector(
          onTap: onTap,
          child: AutoSizeText(
            title,
            style: isCustomFont
                ? GoogleFonts.poppins(
                    color: textColor ?? Colors.black,
                    fontSize: fontSize ?? 13,
                    fontWeight: fontWeight ?? FontWeight.normal,
                    fontStyle: fontStyle,
                    // fontFamily: fontFamily,
                    decoration: decoration,
                    decorationColor: decorationColor,
                  )
                : TextStyle(
                    color: textColor ?? Colors.black,
                    fontSize: fontSize ?? 13,
                    fontWeight: fontWeight ?? FontWeight.normal,
                    fontStyle: fontStyle,
                    fontFamily: fontFamily,
                    decoration: decoration,
                    decorationColor: decorationColor,
                  ),
            minFontSize: minFontSize,
            maxLines: maxLines,
            wrapWords: wrapWords,
            overflow: overflow,
            textAlign: textAlign,
          ),
        ),
      ),
    );
  }
}
