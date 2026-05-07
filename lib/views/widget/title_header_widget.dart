import 'package:flutter/material.dart';

import '../../utilities/_utils.dart';
import '_widget.dart';

class TitleHeaderWidget extends StatelessWidget {
  const TitleHeaderWidget({
    super.key,
    required this.title,
    this.titleFontSize,
    this.titleTextColor,
    this.titleFontWeight,
    this.textButton = 'Show More',
    this.textButtonFontSize,
    this.textButtonColor,
    this.textButtonFontWeight,
    this.isVisibleButton = false,
    this.isVisibleIcon = true,
    this.trailing,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onTap,
  });

  final String title;
  final double? titleFontSize;
  final Color? titleTextColor;
  final FontWeight? titleFontWeight;

  final String textButton;
  final double? textButtonFontSize;
  final Color? textButtonColor;
  final FontWeight? textButtonFontWeight;

  final bool isVisibleButton;
  final bool isVisibleIcon;

  final Widget? trailing; // renamed (more semantic)
  final bool visible;
  final EdgeInsets margin;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    return Padding(
      padding: margin,
      child: Row(
        children: [
          /// TITLE
          Expanded(
            child: CustomText(
              text: title,
              fontSize: titleFontSize ?? 18,
              color: titleTextColor ?? Colors.black,
              fontWeight: titleFontWeight ?? FontWeight.w600,
            ),
          ),

          /// OPTIONAL TRAILING WIDGET
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing!,
          ],

          /// BUTTON
          if (isVisibleButton) ...[
            const SizedBox(width: 8),
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: textButton,
                    fontSize: textButtonFontSize ?? 13,
                    color: textButtonColor ?? greyColor,
                    fontWeight:
                    textButtonFontWeight ?? FontWeight.normal,
                  ),
                  if (isVisibleIcon) ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: textButtonColor ?? greyColor,
                      size: 13,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}