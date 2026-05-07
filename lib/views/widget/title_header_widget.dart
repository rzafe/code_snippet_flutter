
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
  final bool visible;
  final EdgeInsets margin;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: Row(
          children: [
            Expanded(
              child: CustomText(
                text: title,
                fontSize: titleFontSize ?? 18,
                color: titleTextColor ?? Colors.black,
                fontWeight: titleFontWeight ?? FontWeight.w600,
              ),
            ),
            SizedBox(width: 10,),
            Visibility(
              visible: isVisibleButton,
              child: GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    CustomText(
                      text: textButton,
                      fontSize: textButtonFontSize ?? 13,
                      color: textButtonColor ?? greyColor,
                      fontWeight: textButtonFontWeight ?? FontWeight.normal,
                    ),
                    SizedBox(width: 5,),
                    Visibility(
                      visible: isVisibleIcon,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: greyColor,
                        size: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
