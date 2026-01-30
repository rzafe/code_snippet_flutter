
import 'package:flutter/material.dart';

import '_widget.dart';

class FormRequiredLabel extends StatelessWidget {
  const FormRequiredLabel({
    super.key,
    required this.title,
    this.fontSize,
    this.textColor,
    this.fontWeight,
    this.isRequired = true,
    this.visible = true,
    this.margin = EdgeInsets.zero,
  });

  final String title;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final bool isRequired;
  final bool visible;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: CustomRichText(
          spans: [
            MyTextSpan(
              text: title,
              fontSize: fontSize ?? 13,
              color: textColor ?? Colors.black,
              fontWeight: fontWeight,
            ),
            MyTextSpan(
              text: isRequired ? ' *' : '',
              fontSize: 13,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

