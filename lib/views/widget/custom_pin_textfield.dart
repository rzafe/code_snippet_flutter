
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utilities/_utils.dart';

class CustomPinTextField extends StatelessWidget {
  final TextEditingController controller;
  final double? width;
  final double? borderRadius;
  final double? fieldWidth;
  final double? fieldHeight;
  final double? fontSize;
  final int length;
  final Color? textColor;
  final Color? fillColor;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final bool obscureText;
  final bool readOnly;
  final bool isCustomFont;
  final bool visible;
  final EdgeInsets margin;
  final Function(String)? onCompleted;
  final Function(String)? onChanged;

  const CustomPinTextField({
    super.key,
    required this.controller,
    this.width,
    this.borderRadius = 15,
    this.fieldWidth = 50,
    this.fieldHeight = 50,
    this.fontSize,
    this.length = 4,
    this.textColor,
    this.fillColor,
    this.fontWeight,
    this.fontStyle,
    this.fontFamily,
    this.obscureText = true,
    this.readOnly = false,
    this.isCustomFont = true,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onCompleted,
    this.onChanged,
  });

  const CustomPinTextField.otp({
    super.key,
    required this.controller,
    this.width,
    this.borderRadius = 15,
    this.fieldWidth = 45,
    this.fieldHeight = 45,
    this.fontSize,
    this.length = 6,
    this.textColor,
    this.fillColor,
    this.fontWeight,
    this.fontStyle,
    this.fontFamily,
    this.obscureText = true,
    this.readOnly = false,
    this.isCustomFont = true,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onCompleted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: SizedBox(
          width: width,
          child: PinCodeTextField(
            autoDisposeControllers: false,
            controller: controller,
            appContext: context,
            obscureText: obscureText,
            keyboardType: TextInputType.number,
            length: length,
            readOnly: readOnly,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            ],
            enableActiveFill: true,
            cursorColor: primaryColor,
            textStyle: isCustomFont
                ? GoogleFonts.poppins(
                    color: textColor ?? primaryColor,
                    fontSize: fontSize ?? 14,
                    fontWeight: fontWeight ?? FontWeight.normal,
                    fontStyle: fontStyle,
                  )
                : TextStyle(
                    color: textColor ?? primaryColor,
                    fontSize: fontSize ?? 14,
                    fontWeight: fontWeight ?? FontWeight.normal,
                    fontStyle: fontStyle,
                    fontFamily: fontFamily,
                  ),
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(borderRadius ?? 15),
              fieldWidth: fieldWidth,
              fieldHeight: fieldHeight,
              activeColor: Colors.transparent,
              inactiveColor: Colors.transparent,
              selectedColor: Colors.transparent,
              activeFillColor: fillColor ?? Colors.white,
              inactiveFillColor: fillColor ?? Colors.white,
              selectedFillColor: fillColor ?? Colors.white,
            ),
            onCompleted: onCompleted,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
