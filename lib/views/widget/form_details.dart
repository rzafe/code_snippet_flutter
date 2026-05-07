
import 'package:flutter/material.dart';

import '_widget.dart';

class FormDetails extends StatelessWidget {
  const FormDetails({
    super.key,
    required this.value,
    this.fontSize,
    this.textColor,
    this.fontWeight,

    this.widthField,
    this.heightField,
    this.contentPadding,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,

    /// Form Label
    this.formLabel,
    this.formFontSize,
    this.formTextColor,
    this.formFontWeight,
    this.formIsRequired,

    this.visible = true,
    this.margin = EdgeInsets.zero,
  });

  final String value;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;

  final double? widthField;
  final double? heightField;
  final EdgeInsets? contentPadding;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;

  /// Form Label
  final String? formLabel;
  final double? formFontSize;
  final Color? formTextColor;
  final FontWeight? formFontWeight;
  final bool? formIsRequired;

  final bool visible;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (formLabel?.isNotEmpty == true) ...[
              FormRequiredLabel(
                title: formLabel ?? '',
                fontSize: formFontSize ?? 12,
                textColor: formTextColor,
                fontWeight: formFontWeight,
                isRequired: formIsRequired ?? false,
              ),
            ],
            Container(
              padding: contentPadding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: widthField ?? double.infinity,
              height: heightField,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
                border: Border.all(
                  color: borderColor ?? Colors.grey,
                  width: borderWidth ?? 0.5,
                ),
              ),
              child: CustomText(
                text: value,
                fontSize: fontSize,
                color: textColor,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
