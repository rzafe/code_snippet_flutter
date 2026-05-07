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
    this.titleMaxLines,
    this.infoFontSize,
    this.infoColor,
    this.infoFontWeight,
    this.infoMaxLines,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.spacing = 8,
    this.showColon = false,
  });

  final String title;
  final String info;

  final double? titleWidth;
  final double? titleFontSize;
  final Color? titleColor;
  final FontWeight? titleFontWeight;
  final int? titleMaxLines;

  final double? infoFontSize;
  final Color? infoColor;
  final FontWeight? infoFontWeight;
  final int? infoMaxLines;

  final bool visible;
  final EdgeInsets margin;
  final double spacing;
  final bool showColon;

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    return Padding(
      padding: margin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (titleWidth != null)
            SizedBox(
              width: titleWidth,
              child: CustomText(
                text: showColon ? '$title:' : title,
                fontSize: titleFontSize ?? 13,
                color: titleColor ?? Colors.black,
                fontWeight: titleFontWeight ?? FontWeight.normal,
                maxLines: titleMaxLines,
              ),
            )
          else
            CustomText(
              text: showColon ? '$title:' : title,
              fontSize: titleFontSize ?? 13,
              color: titleColor ?? Colors.black,
              fontWeight: titleFontWeight ?? FontWeight.normal,
              maxLines: titleMaxLines,
            ),

          SizedBox(width: spacing),

          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: CustomText(
                text: info,
                fontSize: infoFontSize ?? 13,
                color: infoColor ?? Colors.black,
                fontWeight: infoFontWeight ?? FontWeight.normal,
                maxLines: infoMaxLines,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
