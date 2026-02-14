
import 'package:flutter/material.dart';

import '../../utilities/_utils.dart';
import '_widget.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;

  final double? buttonWidth;
  final double? buttonHeight;
  final Color buttonColor;
  final Color? borderColor;
  final double borderRadius;
  final double? borderWidth;
  final double? elevation;
  final Size? minimumSize;
  final EdgeInsetsGeometry? paddingButton;

  final bool isCustomFont;
  final bool visible;
  final EdgeInsets margin;
  final Function()? onTap;

  /// NEW: prefix & suffix icons (default = null)
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomButton({
    super.key,
    required this.title,
    this.textColor = Colors.white,
    this.fontSize = 15,
    this.fontWeight = FontWeight.bold,
    this.fontStyle,
    this.fontFamily,

    this.buttonWidth,
    this.buttonHeight,
    this.buttonColor = primaryColor,
    this.borderColor,
    this.borderRadius = 10,
    this.borderWidth,
    this.elevation,
    this.minimumSize,
    this.paddingButton,

    this.isCustomFont = true,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: onTap ?? () {},
            style: ElevatedButton.styleFrom(
              padding: paddingButton,
              backgroundColor: buttonColor,
              elevation: elevation,
              minimumSize: minimumSize,
              side: BorderSide(
                color: borderColor ?? Colors.transparent,
                width: borderWidth ?? 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefixIcon != null) ...[
                  prefixIcon!,
                  const SizedBox(width: 6),
                ],
                Flexible(
                  child: CustomText(
                    title: title,
                    fontSize: fontSize,
                    textColor: textColor,
                    fontWeight: fontWeight,
                    fontStyle: fontStyle,
                    fontFamily: fontFamily,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    isCustomFont: isCustomFont,
                  ),
                ),
                if (suffixIcon != null) ...[
                  const SizedBox(width: 6),
                  suffixIcon!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
