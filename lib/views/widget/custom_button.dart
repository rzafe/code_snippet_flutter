
import 'package:flutter/material.dart';

import '../../utilities/_utils.dart';
import '_widget.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final TextDecoration? decoration;
  final Color? decorationColor;

  final double? buttonWidth;
  final double? buttonHeight;
  final Color buttonColor;
  final Color? borderColor;
  final double borderRadius;
  final double? borderWidth;
  final double? elevation;
  final Size? minimumSize;
  final MaterialTapTargetSize? tapTargetSize;
  final VisualDensity? visualDensity;
  final EdgeInsetsGeometry? paddingButton;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? spacing;

  final bool isCustomFont;
  final bool visible;
  final EdgeInsets margin;
  final Function()? onTap;

  const CustomButton({
    super.key,
    required this.text,
    this.textColor = Colors.white,
    this.fontSize = 15,
    this.fontWeight = FontWeight.bold,
    this.fontStyle,
    this.fontFamily,
    this.decoration,
    this.decorationColor,

    this.buttonWidth,
    this.buttonHeight,
    this.buttonColor = primaryColor,
    this.borderColor,
    this.borderRadius = 10,
    this.borderWidth,
    this.elevation,
    this.minimumSize,
    this.tapTargetSize,
    this.visualDensity,
    this.paddingButton,
    this.prefixIcon,
    this.suffixIcon,
    this.spacing,

    this.isCustomFont = true,
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
              tapTargetSize: tapTargetSize ?? MaterialTapTargetSize.shrinkWrap,
              visualDensity: visualDensity ?? VisualDensity.compact,
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
                  SizedBox(width: spacing ?? 6),
                ],
                Flexible(
                  child: CustomText(
                    text: text,
                    fontSize: fontSize,
                    color: textColor,
                    fontWeight: fontWeight,
                    fontStyle: fontStyle,
                    fontFamily: fontFamily,
                    textAlign: TextAlign.center,
                    decoration: decoration,
                    decorationColor: decorationColor,
                    maxLines: 1,
                    isCustomFont: isCustomFont,
                  ),
                ),
                if (suffixIcon != null) ...[
                  SizedBox(width: spacing ?? 6),
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
