import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String title;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? letterSpacing;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool isCustomFont;
  final bool visible;
  final EdgeInsets margin;
  final Function()? onTap;

  // 🔹 New icon properties
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final double iconSpacing;

  const CustomText({
    super.key,
    required this.title,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.fontFamily,
    this.decoration,
    this.decorationColor,
    this.letterSpacing,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.isCustomFont = true,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onTap,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.iconSpacing = 6.0,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: EdgeInsets.only(right: iconSpacing),
                  child: Icon(
                    icon,
                    size: iconSize ?? (fontSize != null ? fontSize! + 2 : 16),
                    color: iconColor ?? textColor ?? Colors.black,
                  ),
                ),
              Flexible(
                child: Text(
                  title,
                  style: isCustomFont
                      ? GoogleFonts.poppins(
                          color: textColor ?? Colors.black,
                          fontSize: fontSize ?? 13,
                          fontWeight: fontWeight ?? FontWeight.normal,
                          fontStyle: fontStyle,
                          decoration: decoration,
                          decorationColor: decorationColor,
                          letterSpacing: letterSpacing,
                        )
                      : TextStyle(
                          color: textColor ?? Colors.black,
                          fontSize: fontSize ?? 13,
                          fontWeight: fontWeight ?? FontWeight.normal,
                          fontStyle: fontStyle,
                          fontFamily: fontFamily,
                          decoration: decoration,
                          decorationColor: decorationColor,
                          letterSpacing: letterSpacing,
                        ),
                  maxLines: maxLines,
                  overflow: overflow,
                  textAlign: textAlign,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
