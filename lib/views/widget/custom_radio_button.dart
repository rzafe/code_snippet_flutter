
import 'package:flutter/material.dart';

import '_widget.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.title,
    required this.index,
    required this.currentIndex,
    this.textColor = Colors.black,
    this.fontSize = 15,
    this.radioSize = 20,
    this.radioActiveColor = Colors.black,
    this.radioInactiveColor = Colors.black,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onTap,
  });

  final String title;
  final int index;
  final int currentIndex;
  final Color textColor;
  final double fontSize;
  final double radioSize;
  final Color radioActiveColor;
  final Color radioInactiveColor;
  final bool visible;
  final EdgeInsets margin;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                currentIndex == index
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: currentIndex == index
                    ? radioActiveColor
                    : radioInactiveColor,
                size: radioSize,
              ),
              SizedBox(width: 5,),
              CustomText(
                title: title,
                textColor: textColor,
                fontSize: fontSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
