
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
  final bool readOnly;
  final bool? enabled;
  final bool obscureText;
  final bool useOutlineBorder;
  final bool? filled;
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
  final double borderRadius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? widthField;
  final double? heightField;
  final bool isCustomFont;
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
    this.readOnly = false,
    this.enabled,
    this.obscureText = false,
    this.useOutlineBorder = true,
    this.filled,
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
    this.fontSize = 15,
    this.borderRadius = 10,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont = true,
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
    this.readOnly = false,
    this.enabled,
    this.obscureText = false,
    this.useOutlineBorder = true,
    this.filled,
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
    this.fontSize = 15,
    this.borderRadius = 10,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont = true,
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
    this.readOnly = false,
    this.enabled,
    this.obscureText = false,
    this.useOutlineBorder = true,
    this.filled,
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
    this.fontSize = 15,
    this.borderRadius = 10,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont = true,
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
    this.readOnly = false,
    this.enabled,
    this.obscureText = false,
    this.useOutlineBorder = true,
    this.filled,
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
    this.fontSize = 15,
    this.borderRadius = 10,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont = true,
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
    this.readOnly = false,
    this.enabled,
    this.obscureText = false,
    this.useOutlineBorder = true,
    this.filled,
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
    this.fontSize = 15,
    this.borderRadius = 10,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont = true,
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
    this.readOnly = false,
    this.enabled,
    this.obscureText = false,
    this.useOutlineBorder = true,
    this.filled,
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
    this.fontSize = 15,
    this.borderRadius = 10,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont = true,
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
    this.readOnly = false,
    this.enabled,
    this.obscureText = false,
    this.useOutlineBorder = true,
    this.filled,
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
    this.fontSize = 15,
    this.borderRadius = 10,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont = true,
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
    this.obscureText = false,
    this.useOutlineBorder = true,
    this.filled,
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
    this.fontSize = 15,
    this.borderRadius = 10,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont = true,
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
    this.obscureText = false,
    this.useOutlineBorder = true,
    this.filled,
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
    this.fontSize = 15,
    this.borderRadius = 10,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont = true,
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
    this.readOnly = false,
    this.enabled,
    this.obscureText = false,
    this.useOutlineBorder = true,
    this.filled,
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
    this.fontSize = 15,
    this.borderRadius = 10,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont = true,
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
    this.readOnly = false,
    this.enabled,
    this.obscureText = true,
    this.useOutlineBorder = true,
    this.filled,
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
    this.fontSize = 15,
    this.borderRadius = 10,
    this.prefixIcon,
    this.suffixIcon,
    this.widthField,
    this.heightField,
    this.isCustomFont = true,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter>? textInput() {
      if (textFieldType == 'name') {
        return [
          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ñÑ]")),
        ];
      } else if (textFieldType == 'pin') {
        return [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          LengthLimitingTextInputFormatter(4),
        ];
      } else if (textFieldType == 'mobile' || textFieldType == 'number') {
        return [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ];
      } else if (textFieldType == 'decimal') {
        return [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ];
      }
      return inputFormatters;
    }

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
            enableInteractiveSelection: false,
            readOnly: readOnly,
            enabled: enabled,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            inputFormatters: textInput(),
            style: isCustomFont
                ? GoogleFonts.poppins(
                    color: styleColor ?? Colors.black,
                    fontSize: fontSize ?? 15,
                  )
                : TextStyle(
                    color: styleColor ?? Colors.black,
                    fontSize: fontSize ?? 15,
                  ),
            maxLength: maxLength,
            maxLines: maxLines,
            decoration: InputDecoration(
              contentPadding: contentPadding,
              labelText: labelText,
              labelStyle: isCustomFont
                  ? GoogleFonts.poppins(
                      color: labelTextColor ?? Colors.grey[700],
                      fontSize: fontSize ?? 15,
                    )
                  : TextStyle(
                      color: labelTextColor ?? Colors.grey[700],
                      fontSize: fontSize ?? 15,
                    ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
              floatingLabelBehavior: floatingLabelBehavior ?? FloatingLabelBehavior.never,
              alignLabelWithHint: true,
              hintText: hintText,
              hintStyle: isCustomFont
                  ? GoogleFonts.poppins(
                      color: hintTextColor ?? Colors.grey,
                      fontSize: fontSize ?? 15,
                    )
                  : TextStyle(
                      color: hintTextColor ?? Colors.grey,
                      fontSize: fontSize ?? 15,
                    ),
              hintMaxLines: hintMaxLines,
              counterText: '',
              errorMaxLines: errorMaxLines,
              fillColor: fillColor ?? Colors.white,
              filled: filled ?? true,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: useOutlineBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(color: enabledBorderColor ?? Colors.grey),
                    ),
              enabledBorder: useOutlineBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      borderSide: BorderSide(
                        color: enabledBorderColor ?? primaryColor,
                        width: 0.5,
                      ),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(color: enabledBorderColor ?? Colors.grey),
                    ),
              focusedBorder: useOutlineBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      borderSide: BorderSide(
                        color: focusedBorderColor ?? primaryColor,
                        width: 1.5,
                      ),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(color: enabledBorderColor ?? Colors.grey),
                    ),
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

/// Prefix Icon Mobile ---------------------------------------------------------
class PrefixIconMobile extends StatelessWidget {
  const PrefixIconMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
      child: Text(
        '+63 ',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }
}

/// Prefix Icon Date -----------------------------------------------------------
class PrefixIconDate extends StatelessWidget {
  const PrefixIconDate({
    super.key,
    this.iconData,
    this.size,
    this.color,
  });

  final IconData? iconData;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Icon(
        iconData ?? Icons.calendar_today_outlined,
        size: size ?? 20,
        color: color ?? Colors.grey,
      ),
    );
  }
}

