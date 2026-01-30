
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 10,
    this.spreadRadius,
    this.blurRadius,
    this.bgColor,
    this.boxShadowColor,
    this.offset,
    this.padding = EdgeInsets.zero,
    this.child,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onTap,
  });

  final double? width;
  final double? height;
  final double borderRadius;
  final double? spreadRadius;
  final double? blurRadius;
  final Color? bgColor;
  final Color? boxShadowColor;
  final Offset? offset;
  final EdgeInsets padding;
  final Widget? child;
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
            padding: padding,
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: bgColor ?? Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: boxShadowColor ?? Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: spreadRadius ?? 1,
                  blurRadius: blurRadius ?? 2,
                  offset: offset ?? Offset(0, 2), /// changes position of shadow
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
