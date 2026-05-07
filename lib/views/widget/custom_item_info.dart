import 'package:flutter/material.dart';

import '_widget.dart';

class CustomItemInfo extends StatelessWidget {
  const CustomItemInfo({
    super.key,

    /// Data
    this.title = '',
    this.info = '',

    /// Custom Widgets
    this.titleWidget,
    this.infoWidget,
    this.leading,
    this.trailing,

    /// Visibility
    this.visible = true,

    /// Layout
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.spacing = 8,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.infoExpanded = true,

    /// Title
    this.titleWidth,
    this.showColon = false,
    this.titleFlex,

    /// Title Text Style
    this.titleFontSize,
    this.titleColor,
    this.titleFontWeight,
    this.titleMaxLines,
    this.titleOverflow,
    this.titleTextAlign,

    /// Info
    this.infoFlex,

    /// Info Text Style
    this.infoFontSize,
    this.infoColor,
    this.infoFontWeight,
    this.infoMaxLines,
    this.infoOverflow,
    this.infoTextAlign,
    this.infoAlignment,

    /// Decoration
    this.backgroundColor,
    this.borderRadius,
    this.border,
  });

  /// =========================
  /// DATA
  /// =========================

  final String title;
  final String info;

  /// =========================
  /// CUSTOM WIDGETS
  /// =========================

  final Widget? titleWidget;
  final Widget? infoWidget;
  final Widget? leading;
  final Widget? trailing;

  /// =========================
  /// VISIBILITY
  /// =========================

  final bool visible;

  /// =========================
  /// LAYOUT
  /// =========================

  final EdgeInsets margin;
  final EdgeInsets padding;
  final double spacing;

  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  final bool infoExpanded;

  /// =========================
  /// TITLE
  /// =========================

  final double? titleWidth;
  final bool showColon;
  final int? titleFlex;

  /// =========================
  /// TITLE STYLE
  /// =========================

  final double? titleFontSize;
  final Color? titleColor;
  final FontWeight? titleFontWeight;
  final int? titleMaxLines;
  final TextOverflow? titleOverflow;
  final TextAlign? titleTextAlign;

  /// =========================
  /// INFO
  /// =========================

  final int? infoFlex;

  /// =========================
  /// INFO STYLE
  /// =========================

  final double? infoFontSize;
  final Color? infoColor;
  final FontWeight? infoFontWeight;
  final int? infoMaxLines;
  final TextOverflow? infoOverflow;
  final TextAlign? infoTextAlign;
  final AlignmentGeometry? infoAlignment;

  /// =========================
  /// DECORATION
  /// =========================

  final Color? backgroundColor;
  final double? borderRadius;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    final Widget titleChild =
        titleWidget ??
            CustomText(
              text: showColon ? '$title:' : title,
              fontSize: titleFontSize ?? 13,
              color: titleColor ?? Colors.black,
              fontWeight: titleFontWeight ?? FontWeight.normal,
              maxLines: titleMaxLines,
              overflow: titleOverflow,
              textAlign: titleTextAlign,
            );

    final Widget infoChild =
        infoWidget ??
            CustomText(
              text: info,
              fontSize: infoFontSize ?? 13,
              color: infoColor ?? Colors.black,
              fontWeight: infoFontWeight ?? FontWeight.normal,
              maxLines: infoMaxLines,
              overflow: infoOverflow,
              textAlign: infoTextAlign ?? TextAlign.end,
            );

    Widget titleSection = titleChild;

    if (titleWidth != null) {
      titleSection = SizedBox(
        width: titleWidth,
        child: titleChild,
      );
    } else if (titleFlex != null) {
      titleSection = Expanded(
        flex: titleFlex!,
        child: titleChild,
      );
    }

    Widget infoSection = Align(
      alignment: infoAlignment ?? Alignment.centerRight,
      child: infoChild,
    );

    if (infoExpanded) {
      infoSection = Expanded(
        flex: infoFlex ?? 1,
        child: infoSection,
      );
    }

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius!)
            : null,
        border: border,
      ),
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          if (leading != null) ...[
            leading!,
            SizedBox(width: spacing),
          ],

          titleSection,

          SizedBox(width: spacing),

          infoSection,

          if (trailing != null) ...[
            SizedBox(width: spacing),
            trailing!,
          ],
        ],
      ),
    );
  }
}