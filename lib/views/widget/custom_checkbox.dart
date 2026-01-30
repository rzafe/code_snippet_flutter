import 'package:flutter/material.dart';

import '_widget.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.title,
    this.fontSize,
    this.isCheck = false,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onTap,
    this.checkedColor,
    this.uncheckedColor,
    this.iconSize,
    this.iconChecked,
    this.iconUnchecked,
    this.textColorChecked,
    this.textColorUnchecked,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final String title;
  final double? fontSize;
  final bool isCheck;
  final bool visible;
  final EdgeInsets margin;
  final Function()? onTap;

  final Color? checkedColor;
  final Color? uncheckedColor;
  final double? iconSize;
  final IconData? iconChecked;
  final IconData? iconUnchecked;
  final Color? textColorChecked;
  final Color? textColorUnchecked;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: Row(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Icon(
                isCheck
                    ? (iconChecked ?? Icons.check_box)
                    : (iconUnchecked ?? Icons.check_box_outline_blank),
                color: isCheck
                    ? (checkedColor ?? Colors.white)
                    : (uncheckedColor ?? Colors.white),
                size: iconSize ?? 24,
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: CustomText(
                title: title,
                textColor: isCheck
                    ? (textColorChecked ?? Colors.white)
                    : (textColorUnchecked ?? Colors.white),
                fontSize: fontSize ?? 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
