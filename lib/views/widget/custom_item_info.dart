
import 'package:flutter/material.dart';

import '_widget.dart';

class CustomItemInfo extends StatelessWidget {
  const CustomItemInfo({
    super.key,
    required this.title,
    required this.info,
    this.titleWidth,
    this.titleFontSize,
    this.titleColor,
    this.titleFontWeight,
    this.infoFontSize,
    this.infoColor,
    this.infoFontWeight,
    this.visible = true,
    this.margin = EdgeInsets.zero,
  });

  final String title;
  final String info;
  final double? titleWidth;
  final double? titleFontSize;
  final Color? titleColor;
  final FontWeight? titleFontWeight;
  final double? infoFontSize;
  final Color? infoColor;
  final FontWeight? infoFontWeight;
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
          spacing: 10,
          children: [
            SizedBox(
              width: titleWidth,
              child: CustomText(
                title: title,
                fontSize: titleFontSize ?? 13,
                textColor: titleColor ?? Colors.grey,
                fontWeight: titleFontWeight ?? FontWeight.normal,
              ),
            ),
            CustomText(
              title: ':',
              fontSize: titleFontSize ?? 13,
              textColor: titleColor ?? Colors.grey,
              fontWeight: titleFontWeight ?? FontWeight.normal,
            ),
            Expanded(
              child: CustomText(
                title: info,
                fontSize: infoFontSize ?? 13,
                textColor: infoColor ?? Colors.black,
                fontWeight: infoFontWeight ?? FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
