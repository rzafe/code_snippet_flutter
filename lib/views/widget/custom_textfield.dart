
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utilities/_utils.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? textFieldType;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final bool? readOnly;
  final bool? enabled;
  final bool? obscureText;
  final bool? useOutlineBorder;
  final bool? filled;
  final bool? enableInteractiveSelection;
  final bool? alignLabelWithHint;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final EdgeInsets? contentPadding;
  final Color? styleColor;
  final Color? labelTextColor;
  final Color? hintTextColor;
  final Color? fillColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final int? maxLength;
  final int? maxLines;
  final int? hintMaxLines;
  final int? errorMaxLines;
  final double? fontSize;
  final double? labelFontSize;
  final double? hintFontSize;
  final double? borderRadius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final double? widthField;
  final double? heightField;
  final bool? isCustomFont;
  final bool visible;
  final EdgeInsets margin;

  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function()? onTap;

  const CustomTextField({
    super.key,
    required this.controller,
    this.textFieldType,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.readOnly,
    this.enabled,
    this.obscureText,
    this.useOutlineBorder,
    this.filled,
    this.enableInteractiveSelection,
    this.alignLabelWithHint,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.floatingLabelBehavior,
    this.contentPadding,
    this.styleColor,
    this.labelTextColor,
    this.hintTextColor,
    this.fillColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.maxLength,
    this.maxLines,
    this.hintMaxLines,
    this.errorMaxLines,
    this.fontSize,
    this.labelFontSize,
    this.hintFontSize,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onTap,
  });

  const CustomTextField.name({
    super.key,
    required this.controller,
    this.textFieldType = 'name',
    this.focusNode,
    this.labelText,
    this.hintText,
    this.readOnly,
    this.enabled,
    this.obscureText,
    this.useOutlineBorder,
    this.filled,
    this.enableInteractiveSelection,
    this.alignLabelWithHint,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.floatingLabelBehavior,
    this.contentPadding,
    this.styleColor,
    this.labelTextColor,
    this.hintTextColor,
    this.fillColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.maxLength,
    this.maxLines,
    this.hintMaxLines,
    this.errorMaxLines,
    this.fontSize,
    this.labelFontSize,
    this.hintFontSize,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onTap,
  });

  const CustomTextField.pin({
    super.key,
    required this.controller,
    this.textFieldType = 'pin',
    this.focusNode,
    this.labelText,
    this.hintText,
    this.readOnly,
    this.enabled,
    this.obscureText,
    this.useOutlineBorder,
    this.filled,
    this.enableInteractiveSelection,
    this.alignLabelWithHint,
    this.keyboardType = TextInputType.number,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.floatingLabelBehavior,
    this.contentPadding,
    this.styleColor,
    this.labelTextColor,
    this.hintTextColor,
    this.fillColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.maxLength,
    this.maxLines,
    this.hintMaxLines,
    this.errorMaxLines,
    this.fontSize,
    this.labelFontSize,
    this.hintFontSize,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onTap,
  });

  const CustomTextField.email({
    super.key,
    required this.controller,
    this.textFieldType = 'email',
    this.focusNode,
    this.labelText,
    this.hintText,
    this.readOnly,
    this.enabled,
    this.obscureText,
    this.useOutlineBorder,
    this.filled,
    this.enableInteractiveSelection,
    this.alignLabelWithHint,
    this.keyboardType = TextInputType.emailAddress,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.floatingLabelBehavior,
    this.contentPadding,
    this.styleColor,
    this.labelTextColor,
    this.hintTextColor,
    this.fillColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.maxLength,
    this.maxLines,
    this.hintMaxLines,
    this.errorMaxLines,
    this.fontSize,
    this.labelFontSize,
    this.hintFontSize,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onTap,
  });

  const CustomTextField.mobile({
    super.key,
    required this.controller,
    this.textFieldType = 'mobile',
    this.focusNode,
    this.labelText,
    this.hintText,
    this.readOnly,
    this.enabled,
    this.obscureText,
    this.useOutlineBorder,
    this.filled,
    this.enableInteractiveSelection,
    this.alignLabelWithHint,
    this.keyboardType = TextInputType.number,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.floatingLabelBehavior,
    this.contentPadding,
    this.styleColor,
    this.labelTextColor,
    this.hintTextColor,
    this.fillColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.maxLength = 10,
    this.maxLines,
    this.hintMaxLines,
    this.errorMaxLines,
    this.fontSize,
    this.labelFontSize,
    this.hintFontSize,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onTap,
  });

  const CustomTextField.number({
    super.key,
    required this.controller,
    this.textFieldType = 'number',
    this.focusNode,
    this.labelText,
    this.hintText,
    this.readOnly,
    this.enabled,
    this.obscureText,
    this.useOutlineBorder,
    this.filled,
    this.enableInteractiveSelection,
    this.alignLabelWithHint,
    this.keyboardType = TextInputType.number,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.floatingLabelBehavior,
    this.contentPadding,
    this.styleColor,
    this.labelTextColor,
    this.hintTextColor,
    this.fillColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.maxLength,
    this.maxLines,
    this.hintMaxLines,
    this.errorMaxLines,
    this.fontSize,
    this.labelFontSize,
    this.hintFontSize,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onTap,
  });

  const CustomTextField.decimal({
    super.key,
    required this.controller,
    this.textFieldType = 'decimal',
    this.focusNode,
    this.labelText,
    this.hintText,
    this.readOnly,
    this.enabled,
    this.obscureText,
    this.useOutlineBorder,
    this.filled,
    this.enableInteractiveSelection,
    this.alignLabelWithHint,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.floatingLabelBehavior,
    this.contentPadding,
    this.styleColor,
    this.labelTextColor,
    this.hintTextColor,
    this.fillColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.maxLength,
    this.maxLines,
    this.hintMaxLines,
    this.errorMaxLines,
    this.fontSize,
    this.labelFontSize,
    this.hintFontSize,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onTap,
  });

  const CustomTextField.date({
    super.key,
    required this.controller,
    this.textFieldType = 'date',
    this.focusNode,
    this.labelText,
    this.hintText = 'YYYY-MM-DD',
    this.readOnly = true,
    this.enabled,
    this.obscureText,
    this.useOutlineBorder,
    this.filled,
    this.enableInteractiveSelection,
    this.alignLabelWithHint,
    this.keyboardType = TextInputType.number,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.floatingLabelBehavior,
    this.contentPadding,
    this.styleColor,
    this.labelTextColor,
    this.hintTextColor,
    this.fillColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.maxLength,
    this.maxLines,
    this.hintMaxLines,
    this.errorMaxLines,
    this.fontSize,
    this.labelFontSize,
    this.hintFontSize,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onTap,
  });

  const CustomTextField.time({
    super.key,
    required this.controller,
    this.textFieldType = 'time',
    this.focusNode,
    this.labelText,
    this.hintText = '00:00 PM',
    this.readOnly = true,
    this.enabled,
    this.obscureText,
    this.useOutlineBorder,
    this.filled,
    this.enableInteractiveSelection,
    this.alignLabelWithHint,
    this.keyboardType = TextInputType.number,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.floatingLabelBehavior,
    this.contentPadding,
    this.styleColor,
    this.labelTextColor,
    this.hintTextColor,
    this.fillColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.maxLength,
    this.maxLines,
    this.hintMaxLines,
    this.errorMaxLines,
    this.fontSize,
    this.labelFontSize,
    this.hintFontSize,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onTap,
  });

  const CustomTextField.search({
    super.key,
    required this.controller,
    this.textFieldType = 'search',
    this.focusNode,
    this.labelText,
    this.hintText = 'Search',
    this.readOnly,
    this.enabled,
    this.obscureText,
    this.useOutlineBorder,
    this.filled,
    this.enableInteractiveSelection,
    this.alignLabelWithHint,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.floatingLabelBehavior,
    this.contentPadding,
    this.styleColor,
    this.labelTextColor,
    this.hintTextColor,
    this.fillColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.maxLength,
    this.maxLines,
    this.hintMaxLines,
    this.errorMaxLines,
    this.fontSize,
    this.labelFontSize,
    this.hintFontSize,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onTap,
  });

  const CustomTextField.password({
    super.key,
    required this.controller,
    this.textFieldType = 'password',
    this.focusNode,
    this.labelText,
    this.hintText,
    this.readOnly,
    this.enabled,
    this.obscureText = true,
    this.useOutlineBorder,
    this.filled,
    this.enableInteractiveSelection,
    this.alignLabelWithHint,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.floatingLabelBehavior,
    this.contentPadding,
    this.styleColor,
    this.labelTextColor,
    this.hintTextColor,
    this.fillColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.maxLength,
    this.maxLines = 1,
    this.hintMaxLines,
    this.errorMaxLines,
    this.fontSize,
    this.labelFontSize,
    this.hintFontSize,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onTap,
  });

  /// Determines input formatters based on textFieldType
  List<TextInputFormatter>? _getInputFormatters() {
    List<TextInputFormatter> defaultFormatters = [];

    switch (textFieldType) {
      case 'name':
        defaultFormatters.add(FilteringTextInputFormatter.allow(RegExp(r"[0-9a-zA-Z ñÑ]")));
        break;
      case 'pin':
        defaultFormatters.addAll([
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(maxLength ?? 4),
        ]);
        break;
      case 'mobile':
      case 'number':
        defaultFormatters.add(FilteringTextInputFormatter.digitsOnly);
        break;
      case 'decimal':
        defaultFormatters.add(FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')));
        break;
    }

    // Merge with user-provided inputFormatters if any
    if (inputFormatters != null && inputFormatters!.isNotEmpty) {
      defaultFormatters.addAll(inputFormatters!);
    }

    return defaultFormatters.isEmpty ? null : defaultFormatters;
  }

  InputBorder _buildBorder({Color? color, double width = 1.0}) {
    final bool outline = useOutlineBorder ?? true;

    if (outline) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        borderSide: BorderSide(
          color: color ?? primaryColor,
          width: width,
        ),
      );
    } else {
      return UnderlineInputBorder(
        borderSide: BorderSide(
          color: color ?? Colors.grey,
          width: width,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool custom = isCustomFont ?? true;
    final TextStyle textStyle = custom
        ? GoogleFonts.poppins(color: styleColor ?? Colors.black, fontSize: fontSize ?? 15)
        : TextStyle(color: styleColor ?? Colors.black, fontSize: fontSize ?? 15);

    final TextStyle labelStyle = custom
        ? GoogleFonts.poppins(color: labelTextColor ?? Colors.grey[700], fontSize: labelFontSize ?? 15)
        : TextStyle(color: labelTextColor ?? Colors.grey[700], fontSize: labelFontSize ?? 15);

    final TextStyle hintStyle = custom
        ? GoogleFonts.poppins(color: hintTextColor ?? Colors.grey, fontSize: hintFontSize ?? 15)
        : TextStyle(color: hintTextColor ?? Colors.grey, fontSize: hintFontSize ?? 15);

    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: SizedBox(
          width: widthField,
          height: heightField,
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            enableInteractiveSelection: enableInteractiveSelection ?? false,
            readOnly: readOnly ?? false,
            enabled: enabled,
            obscureText: obscureText ?? false,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            inputFormatters: _getInputFormatters(),
            style: textStyle,
            maxLength: maxLength,
            maxLines: maxLines,
            decoration: InputDecoration(
              contentPadding: contentPadding,
              labelText: labelText,
              labelStyle: labelStyle,
              suffixIconConstraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
              floatingLabelBehavior: floatingLabelBehavior ?? FloatingLabelBehavior.never,
              alignLabelWithHint: alignLabelWithHint ?? true,
              hintText: hintText,
              hintStyle: hintStyle,
              hintMaxLines: hintMaxLines,
              counterText: '',
              errorMaxLines: errorMaxLines,
              fillColor: fillColor ?? Colors.white,
              filled: filled ?? true,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: _buildBorder(color: enabledBorderColor, width: 0.5),
              enabledBorder: _buildBorder(color: enabledBorderColor, width: 0.5),
              focusedBorder: _buildBorder(color: focusedBorderColor, width: 1.5),
            ),
            onFieldSubmitted: onSubmitted,
            validator: validator,
            onChanged: onChanged,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}

/// TextField Icon -------------------------------------------------------------
class IconTextFieldWidget extends StatelessWidget {
  const IconTextFieldWidget({
    super.key,
    required this.iconData,
    this.iconColor,
    this.iconSize,
    this.margin = EdgeInsets.zero,
    this.onTap,
  });

  final IconData iconData;
  final Color? iconColor;
  final double? iconSize;
  final EdgeInsets margin;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          iconData,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}

