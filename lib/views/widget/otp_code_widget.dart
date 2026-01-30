
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utilities/colors.dart';
import '_widget.dart';

class OTPCodeTextField extends StatelessWidget {
  const OTPCodeTextField({
    super.key,
    required this.textController,
    this.width,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onCompleted,
  });

  final TextEditingController textController;
  final double? width;
  final bool visible;
  final EdgeInsets margin;
  final Function(String)? onCompleted;

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
            controller: textController,
            appContext: context,
            obscureText: false,
            keyboardType: TextInputType.number,
            length: 6,
            enableActiveFill: true,
            cursorColor: primaryColor,
            textStyle: const TextStyle(color: Colors.black),
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(15),
              fieldHeight: 50,
              fieldWidth: 50,
              activeColor: primaryColor.withValues(alpha: .5),
              inactiveColor: primaryColor.withValues(alpha: .5),
              selectedColor: primaryColor.withValues(alpha: .5),
              activeFillColor: primaryColor.withValues(alpha: .5),
              inactiveFillColor: primaryColor.withValues(alpha: .5),
              selectedFillColor: primaryColor.withValues(alpha: .5),
            ),
            onCompleted: onCompleted,
            onChanged: (String value) {},
          ),
        ),
      ),
    );
  }
}

/// OTP Resend Code Text -------------------------------------------------------
class OTPResendCodeText extends StatelessWidget {
  const OTPResendCodeText({
    super.key,
    required this.text,
    this.visible = true,
    this.margin = EdgeInsets.zero,
  });

  final String text;
  final bool visible;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: CustomText(
          title:
          text,
            fontSize: 15,
            textColor: Colors.black,
        ),
      ),
    );
  }
}

/// OTP Resend Code Button -----------------------------------------------------
class OTPResendCodeButton extends StatelessWidget {
  const OTPResendCodeButton({
    super.key,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onTap,
  });

  final bool visible;
  final EdgeInsets margin;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: InkWell(
          onTap: onTap as void Function()?,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: primaryColor),
            ),
            child: const CustomText(
              title: 'Resend OTP',
              fontWeight: FontWeight.bold,
              fontSize: 15,
              textColor: primaryColor,
              fontStyle: FontStyle.normal,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}
