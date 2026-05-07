
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../_widget.dart';

/// ----------------------------------------------------------------------------
PreferredSizeWidget appBarWidget(BuildContext context, {
  String? title,
  double? fontSize,
  Color? textColor,
  FontWeight? fontWeight,
  int? maxLines,
  Widget? titleWidget,
  SystemUiOverlayStyle? systemOverlayStyle,
  Color? backgroundColor,
  bool? isCenterTitle,
  double? elevation,
  double? titleSpacing,
  Color? surfaceTintColor,
  bool? automaticallyImplyLeading,
  Color? iconColor,
  double? iconSize,
  bool isHideBackButton = false,
  List<Widget>? actions,
  Function()? onTap,
}) {
  return AppBar(
    title: titleWidget ?? CustomText(
      text: title ?? '',
      fontSize: fontSize ?? 20,
      color: textColor ?? Colors.black,
      fontWeight: fontWeight ?? FontWeight.w600,
      maxLines: maxLines,
    ),
    systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle.dark,
    backgroundColor: backgroundColor ?? Colors.transparent,
    centerTitle: isCenterTitle ?? false,
    elevation: elevation ?? 0,
    titleSpacing: titleSpacing ?? 0,
    surfaceTintColor: surfaceTintColor ?? Colors.transparent,
    automaticallyImplyLeading: automaticallyImplyLeading ?? false,
    leading: isHideBackButton ? null : IconButton(
      onPressed: onTap ?? () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: iconColor ?? Colors.black,
        size: iconSize,
      ),
    ),
    actions: actions,
  );
}
