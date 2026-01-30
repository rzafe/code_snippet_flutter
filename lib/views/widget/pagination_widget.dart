
import 'package:flutter/material.dart';

import '../../utilities/_utils.dart';

class PageIconWidget extends StatelessWidget {
  const PageIconWidget({
    super.key,
    required this.icon,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onTap,
  });

  final IconData icon;
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
          child: Container(
            width: width(context) * .08,
            height: width(context) * .08,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: Colors.grey,
              size: 15,
            ),
          ),
        ),
      ),
    );
  }
}

/// -----------------------------------------------------------------------
class PageNumberWidget extends StatelessWidget {
  const PageNumberWidget({
    super.key,
    required this.title,
    required this.index,
    required this.currentIndex,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onTap,
  });

  final String title;
  final int index;
  final int currentIndex;
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
          child: Container(
            width: width(context) * .08,
            height: width(context) * .08,
            decoration: BoxDecoration(
              color: currentIndex == index ? primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: currentIndex == index ? Colors.transparent : Colors.grey,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: currentIndex == index ? Colors.white : Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
