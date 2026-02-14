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
    this.hasShadow = true,
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
  final VoidCallback? onTap;
  final bool hasShadow;

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    final BorderRadius border = BorderRadius.circular(borderRadius);

    return Padding(
      padding: margin,
      child: Material(
        color: Colors.transparent,
        borderRadius: border,
        child: InkWell(
          borderRadius: border,
          onTap: onTap,
          child: Container(
            padding: padding,
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: bgColor ?? Colors.white,
              borderRadius: border,
              boxShadow: hasShadow ? [
                BoxShadow(
                  color: boxShadowColor ?? Colors.black26,
                  spreadRadius: spreadRadius ?? 1,
                  blurRadius: blurRadius ?? 4,
                  offset: offset ?? const Offset(0, 2),
                ),
              ] : null,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
