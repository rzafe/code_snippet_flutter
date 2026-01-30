import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utilities/_utils.dart';

class PinCodeTextFieldWidget extends StatelessWidget {
  const PinCodeTextFieldWidget({
    super.key,
    required this.textController,
    this.width,
    this.obscureText = false,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.scrollPadding = const EdgeInsets.all(20),
    this.onCompleted,
  });

  final TextEditingController textController;
  final double? width;
  final bool obscureText;
  final bool visible;
  final EdgeInsets margin;
  final EdgeInsets scrollPadding;
  final Function(String)? onCompleted;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: Center(
          child: SizedBox(
            width: width,
            child: PinCodeTextField(
              autoDisposeControllers: false,
              scrollPadding: scrollPadding,
              controller: textController,
              appContext: context,
              obscureText: obscureText,
              keyboardType: TextInputType.number,
              length: 4,
              enableActiveFill: true,
              cursorColor: primaryColor,
              textStyle: const TextStyle(color: primaryColor),
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
      ),
    );
  }
}
