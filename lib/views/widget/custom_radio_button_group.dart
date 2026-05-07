import 'package:flutter/material.dart';

import '../../utilities/_utils.dart';
import '_widget.dart';

class DynamicRadioGroup extends StatefulWidget {
  final String? title;
  final List<String> options;
  final String? initialValue;
  final double? titleFontSize;
  final Color? titleTextColor;
  final FontWeight? titleFontWeight;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? radioFontSize;
  final bool visible;
  final EdgeInsets margin;
  final EdgeInsets? padding;
  final EdgeInsets? titlePadding;
  final Widget? bottomWidget;
  final ValueChanged<String?> onChanged;

  const DynamicRadioGroup({
    super.key,
    this.title,
    required this.options,
    this.initialValue,
    this.titleFontSize,
    this.titleTextColor,
    this.titleFontWeight,
    this.backgroundColor,
    this.borderColor,
    this.radioFontSize,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.padding,
    this.titlePadding,
    this.bottomWidget,
    required this.onChanged,
  });

  @override
  State<DynamicRadioGroup> createState() => _DynamicRadioGroupState();
}

class _DynamicRadioGroupState extends State<DynamicRadioGroup> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant DynamicRadioGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _selectedValue = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: Padding(
        padding: widget.margin,
        child: Container(
          padding: widget.padding ?? const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? secondaryColor.withValues(alpha: .2),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: widget.borderColor ?? Colors.transparent),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null && widget.title!.isNotEmpty) ...[
                CustomText(
                  text: widget.title ?? '',
                  fontSize: widget.titleFontSize ?? 15,
                  color: widget.titleTextColor ?? Colors.black,
                  fontWeight: widget.titleFontWeight ?? FontWeight.w500,
                  margin: widget.titlePadding ?? EdgeInsets.zero,
                ),
              ],
              RadioGroup<String>(
                groupValue: _selectedValue,
                onChanged: (value) {
                  setState(() => _selectedValue = value);
                  widget.onChanged(value);
                },
                child: Column(
                  children: widget.options.map((option) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.grey,
                      ),
                      child: RadioListTile<String>(
                        title: CustomText(
                          text: option,
                          color: Colors.black,
                          fontSize: widget.radioFontSize ?? 15,
                        ),
                        value: option,
                        toggleable: true,
                        activeColor: primaryColor,
                        radioSide: const BorderSide(color: Colors.grey, width: 2),
                        controlAffinity: ListTileControlAffinity.leading,
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    );
                  }).toList(),
                ),
              ),
              if (widget.bottomWidget != null) widget.bottomWidget!,
            ],
          ),
        ),
      ),
    );
  }
}

/// ----------------------------------------------------------------------------
class DynamicTwoSideRadioGroup extends StatefulWidget {
  final String? title;
  final List<String> options;
  final String? initialValue;
  final double? titleFontSize;
  final Color? titleTextColor;
  final FontWeight? titleFontWeight;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool visible;
  final EdgeInsets margin;
  final EdgeInsets? padding;
  final ValueChanged<String?> onChanged;
  final ValueChanged<String?>? onOtherChanged;

  const DynamicTwoSideRadioGroup({
    super.key,
    this.title,
    required this.options,
    this.initialValue,
    this.titleFontSize,
    this.titleTextColor,
    this.titleFontWeight,
    this.backgroundColor,
    this.borderColor,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.padding,
    required this.onChanged,
    this.onOtherChanged,
  });

  @override
  State<DynamicTwoSideRadioGroup> createState() => _DynamicTwoSideRadioGroupState();
}

class _DynamicTwoSideRadioGroupState extends State<DynamicTwoSideRadioGroup> {
  String? _selectedValue;
  final TextEditingController _otherController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 🔑 Responsive: decide how many columns
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 400 ? 1 : 2;

    return Visibility(
      visible: widget.visible,
      child: Padding(
        padding: widget.margin,
        child: Container(
          padding: widget.padding ?? const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? secondaryColor.withValues(alpha: .2),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: widget.borderColor ?? Colors.transparent),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null && widget.title!.isNotEmpty) ...[
                CustomText(
                  text: widget.title ?? '',
                  fontSize: widget.titleFontSize ?? 15,
                  color: widget.titleTextColor ?? Colors.black,
                  fontWeight: widget.titleFontWeight ?? FontWeight.w500,
                ),
                const SizedBox(height: 8),
              ],

              GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 3.95,
                mainAxisSpacing: 0,
                crossAxisSpacing: 12,
                children: widget.options.map((option) {
                  return RadioGroup<String>(
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() => _selectedValue = value);
                      widget.onChanged(value);
                    },
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.grey,
                      ),
                      child: RadioListTile<String>(
                        title: CustomText(
                          text: option,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        value: option,
                        toggleable: true,
                        controlAffinity: ListTileControlAffinity.leading,
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  );
                }).toList(),
              ),

              if (_selectedValue == 'Others') ...[
                CustomTextField(
                  controller: _otherController,
                  hintText: 'Others: please specify',
                  maxLines: 1,
                  borderRadius: 30,
                  enabledBorderColor: Colors.transparent,
                  margin: const EdgeInsets.only(top: 10),
                  onChanged: widget.onOtherChanged,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
