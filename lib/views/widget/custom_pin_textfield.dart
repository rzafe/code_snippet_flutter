import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinTextField extends StatelessWidget {
  final TextEditingController controller;

  final double? width;
  final double borderRadius;
  final double fieldWidth;
  final double fieldHeight;
  final double fontSize;

  final int length;

  final Color? textColor;
  final Color? fillColor;
  final Color? cursorColor;
  final Color? borderColor;
  final double borderWidth;

  final FontWeight fontWeight;
  final FontStyle? fontStyle;
  final String? fontFamily;

  final bool obscureText;
  final String obscuringCharacter;

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
    this.fontSize = 14,
    this.length = 4,
    this.textColor,
    this.fillColor,
    this.cursorColor,
    this.borderColor,
    this.borderWidth = 1.2,
    this.fontWeight = FontWeight.normal,
    this.fontStyle,
    this.fontFamily,
    this.obscureText = true,
    this.obscuringCharacter = "●",
    this.readOnly = false,
    this.isCustomFont = true,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onCompleted,
    this.onChanged,
  });

  /// OTP constructor (6 digits, not obscured by default)
  const CustomPinTextField.otp({
    super.key,
    required this.controller,
    this.width,
    this.borderRadius = 15,
    this.fieldWidth = 45,
    this.fieldHeight = 45,
    this.fontSize = 14,
    this.length = 6,
    this.textColor,
    this.fillColor,
    this.cursorColor,
    this.borderColor,
    this.borderWidth = 1.2,
    this.fontWeight = FontWeight.normal,
    this.fontStyle,
    this.fontFamily,
    this.obscureText = false,
    this.obscuringCharacter = "●",
    this.readOnly = false,
    this.isCustomFont = true,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onCompleted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    final theme = Theme.of(context);

    final baseStyle = TextStyle(
      color: textColor ?? theme.primaryColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );

    return Padding(
      padding: margin,
      child: SizedBox(
        width: width,
        child: PinCodeTextField(
          appContext: context,
          controller: controller,
          autoDisposeControllers: false,
          length: length,
          readOnly: readOnly,
          obscureText: obscureText,
          obscuringCharacter: obscuringCharacter,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          enableActiveFill: true,
          cursorColor: cursorColor ?? theme.primaryColor,
          textStyle: isCustomFont
              ? GoogleFonts.poppins(textStyle: baseStyle)
              : baseStyle.copyWith(fontFamily: fontFamily),
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(borderRadius),
            fieldWidth: fieldWidth,
            fieldHeight: fieldHeight,
            borderWidth: borderWidth,
            activeColor: borderColor ?? theme.primaryColor,
            inactiveColor: borderColor ?? Colors.grey.shade400,
            selectedColor: borderColor ?? theme.primaryColor,
            activeFillColor: fillColor ?? Colors.white,
            inactiveFillColor: fillColor ?? Colors.white,
            selectedFillColor: fillColor ?? Colors.white,
          ),
          onCompleted: onCompleted,
          onChanged: onChanged ?? (_) {},
        ),
      ),
    );
  }
}
