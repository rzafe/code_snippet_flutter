import 'package:flutter/material.dart';

import '../../utilities/_utils.dart';

class CustomButtonIcon extends StatelessWidget {
  const CustomButtonIcon({
    super.key,

    /// Content
    this.image,
    this.iconData,
    this.child,

    /// Size
    this.width,
    this.height,
    this.constraints,

    /// Style
    this.buttonColor,
    this.disabledColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.shape,
    this.elevation,
    this.shadowColor,
    this.gradient,

    /// Spacing
    this.padding = const EdgeInsets.all(8),
    this.margin = EdgeInsets.zero,

    /// Image
    this.imageWidth,
    this.imageHeight,
    this.imageBoxFit = BoxFit.contain,
    this.imageColor,

    /// Icon
    this.iconSize = 20,
    this.iconColor,

    /// Interaction
    this.onTap,
    this.onLongPress,
    this.visible = true,
    this.enableFeedback = true,

    /// Effects
    this.opacity,
    this.splashColor,
    this.highlightColor,
    this.hoverColor,

    /// Alignment
    this.alignment = Alignment.center,
  }) : assert(
  image != null || iconData != null || child != null,
  'Provide image, iconData, or child',
  );

  /// Content
  final String? image;
  final IconData? iconData;
  final Widget? child;

  /// Size
  final double? width;
  final double? height;
  final BoxConstraints? constraints;

  /// Style
  final Color? buttonColor;
  final Color? disabledColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final ShapeBorder? shape;
  final double? elevation;
  final Color? shadowColor;
  final Gradient? gradient;

  /// Spacing
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  /// Image
  final double? imageWidth;
  final double? imageHeight;
  final BoxFit imageBoxFit;
  final Color? imageColor;

  /// Icon
  final double iconSize;
  final Color? iconColor;

  /// Interaction
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool visible;
  final bool enableFeedback;

  /// Effects
  final double? opacity;
  final Color? splashColor;
  final Color? highlightColor;
  final Color? hoverColor;

  /// Alignment
  final AlignmentGeometry alignment;

  bool get _isDisabled => onTap == null;

  BorderRadius get _radius =>
      BorderRadius.circular(borderRadius ?? 10);

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox.shrink();
    }

    final Color backgroundColor = _isDisabled
        ? (disabledColor ?? Colors.grey.shade400)
        : (buttonColor ?? primaryColor);

    return Padding(
      padding: margin,
      child: Opacity(
        opacity: opacity ?? (_isDisabled ? 0.6 : 1),
        child: Material(
          color: gradient == null
              ? backgroundColor
              : Colors.transparent,
          elevation: elevation ?? 0,
          shadowColor: shadowColor,
          borderRadius: shape == null ? _radius : null,
          shape: shape,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: _isDisabled ? null : onTap,
            onLongPress: _isDisabled ? null : onLongPress,
            borderRadius: shape == null ? _radius : null,
            customBorder: shape,
            enableFeedback: enableFeedback,
            splashColor: splashColor,
            highlightColor: highlightColor,
            hoverColor: hoverColor,
            child: Container(
              width: width,
              height: height,
              constraints: constraints,
              decoration: BoxDecoration(
                color: gradient == null
                    ? backgroundColor
                    : null,
                gradient: gradient,
                borderRadius: shape == null ? _radius : null,
                border: Border.all(
                  color: borderColor ?? Colors.transparent,
                  width: borderWidth ?? 1,
                ),
              ),
              child: Padding(
                padding: padding,
                child: Align(
                  alignment: alignment,
                  child: _buildContent(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    /// Custom Child
    if (child != null) {
      return child!;
    }

    /// Icon
    if (iconData != null) {
      return Icon(
        iconData,
        size: iconSize,
        color: iconColor,
      );
    }

    /// Asset Image
    if (image != null && image!.trim().isNotEmpty) {
      return Image.asset(
        image!,
        width: imageWidth,
        height: imageHeight,
        fit: imageBoxFit,
        color: imageColor,
      );
    }

    return const SizedBox.shrink();
  }
}