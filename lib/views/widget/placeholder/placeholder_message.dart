
import 'package:flutter/material.dart';

import '../../../utilities/_utils.dart';
import '../_widget.dart';

class PlaceholderMessage extends StatelessWidget {
  const PlaceholderMessage({
    super.key,
    required this.message,
    this.textColor,
    this.fontSize,
    this.widthHolder,
    this.heightHolder,
    this.fontWeight,
    this.visible = true,
    this.margin = EdgeInsets.zero,
  });

  final String message;
  final Color? textColor;
  final double? fontSize;
  final double? widthHolder;
  final double? heightHolder;
  final FontWeight? fontWeight;
  final bool visible;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: SizedBox(
          width: widthHolder,
          height: heightHolder ?? height(context) * .1,
          child: Center(
            child: CustomText(
              title: message,
              fontSize: fontSize ?? 15,
              textColor: textColor ?? Colors.grey,
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}