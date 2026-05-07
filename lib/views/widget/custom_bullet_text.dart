
import 'package:flutter/material.dart';

import '_widget.dart';

class CustomBulletText extends StatelessWidget {
  const CustomBulletText({
    super.key,
    required this.title,
    this.bullet = '•',
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.bulletColor,
    this.bulletSize,
    this.bulletFontWeight,
    this.isCustomFont = true,
    this.visible = true,
    this.margin = EdgeInsets.zero,
  });

  final String title;
  final String bullet;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final Color? bulletColor;
  final double? bulletSize;
  final FontWeight? bulletFontWeight;
  final bool isCustomFont;
  final bool visible;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (bullet.isNotEmpty) ...[
              CustomText(
                text: bullet,
                fontSize: bulletSize ?? 13,
                color: bulletColor ?? Colors.black,
                fontWeight: bulletFontWeight ?? FontWeight.normal,
                maxLines: 1,
              ),
              SizedBox(width: 5),
            ],
            Expanded(
              child: CustomText(
                text: title,
                fontSize: fontSize ?? 13,
                color: textColor ?? Colors.black,
                fontWeight: fontWeight ?? FontWeight.normal,
                maxLines: maxLines,
                overflow: overflow,
                textAlign: textAlign,
                isCustomFont: isCustomFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
