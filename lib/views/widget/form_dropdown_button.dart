import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/common/_common.dart';
import '../../data/model/_model.dart';
import '_widget.dart';

List<PHLocation> _removeDuplicates(List<PHLocation> items) {
  List<PHLocation> uniqueItems = [];

  /// uniqueList
  var uniqueIDs = items.map((e) => e.region).toSet();

  /// list if UniqueID to remove duplicates
  for (var e in uniqueIDs) {
    uniqueItems.add(items.firstWhere((i) => i.region == e));
  }

  /// populate uniqueItems with equivalent original Batch items
  return uniqueItems;

  ///send back the unique items list
}

/// DropDown Button Widget -----------------------------------------------------
class DropDownButtonWidget extends StatelessWidget {
  const DropDownButtonWidget({
    super.key,
    required this.items,
    required this.value,
    this.hint,
    this.hintFontSize,
    this.hintTextColor,
    required this.searchController,
    this.hintSearch,
    this.isHideDropdownSearchData = false,
    this.iconData,
    this.iconColor,
    this.isCustomFont = true,
    this.hasUnderline = false,
    this.buttonStylePadding,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onChanged,
  });

  final dynamic items;
  final String? value;
  final String? hint;
  final double? hintFontSize;
  final Color? hintTextColor;

  final TextEditingController searchController;
  final String? hintSearch;
  final bool isHideDropdownSearchData;

  final IconData? iconData;
  final Color? iconColor;

  final bool isCustomFont;
  final bool hasUnderline;
  final EdgeInsets? buttonStylePadding;

  final bool visible;
  final EdgeInsets margin;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            barrierColor: Colors.black.withValues(alpha: .1),
            hint: CustomText(
              text: hint ?? '',
              fontSize: hintFontSize ?? 15,
              color: hintTextColor ?? Colors.grey,
              textAlign: TextAlign.start,
              isCustomFont: isCustomFont,
            ),
            iconStyleData: IconStyleData(
              icon: Icon(
                iconData ?? Icons.keyboard_arrow_down,
                color: iconColor ?? Colors.grey,
              ),
            ),
            buttonStyleData: ButtonStyleData(
              padding: buttonStylePadding ?? const EdgeInsets.fromLTRB(14, 0, 14, 0),
              width: width,
              decoration: BoxDecoration(
                color: hasUnderline ? null : Colors.white,
                border: hasUnderline
                    ? const Border(
                        bottom: BorderSide(color: Colors.grey, width: 1.0),
                      )
                    : Border.all(color: Colors.grey),
                borderRadius: hasUnderline ? null : BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            items: items,
            value: value,
            onChanged: onChanged,
            dropdownStyleData: DropdownStyleData(
              maxHeight: height * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: WidgetStateProperty.all(6),
                thumbVisibility: WidgetStateProperty.all(true),
              ),
            ),
            dropdownSearchData: isHideDropdownSearchData ? null : DropdownSearchData(
              searchController: searchController,
              searchInnerWidgetHeight: 60,
              searchInnerWidget: Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                // height: height * 0.08,
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: hintSearch ?? '',
                    hintStyle: isCustomFont
                        ? GoogleFonts.poppins(fontSize: 15)
                        : const TextStyle(fontSize: 15),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                final val = item.value ?? '';
                return val.toUpperCase().contains(searchValue.toUpperCase());
              },
            ),
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                searchController.clear();
              }
            },
          ),
        ),
      ),
    );
  }
}

/// Form Default Picker --------------------------------------------------------
class FormDefaultPicker extends StatefulWidget {
  const FormDefaultPicker({
    super.key,
    required this.item,
    required this.value,
    this.fontSize,
    this.textColor,
    this.fontWeight,
    this.hint,
    this.hintSearch,
    this.isHideDropdownSearchData = false,
    this.iconData,
    this.iconColor,
    this.isEnabled = true,
    this.isCustomFont = true,
    this.hasUnderline = false,
    this.buttonStylePadding,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onChanged,

    /// Form Label
    this.formLabel,
    this.formFontSize,
    this.formTextColor,
    this.formFontWeight,
    this.formIsRequired,
  });

  final List<String> item;
  final String? value;

  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;

  final String? hint;
  final String? hintSearch;
  final bool isHideDropdownSearchData;

  final IconData? iconData;
  final Color? iconColor;

  final bool isEnabled;
  final bool isCustomFont;
  final bool hasUnderline;
  final EdgeInsets? buttonStylePadding;

  final bool visible;
  final EdgeInsets margin;
  final Function(String?)? onChanged;

  /// Form Label
  final String? formLabel;
  final double? formFontSize;
  final Color? formTextColor;
  final FontWeight? formFontWeight;
  final bool? formIsRequired;

  @override
  State<FormDefaultPicker> createState() => _FormDefaultPickerState();
}

class _FormDefaultPickerState extends State<FormDefaultPicker> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: Padding(
        padding: widget.margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.formLabel?.isNotEmpty == true) ...[
              FormRequiredLabel(
                title: widget.formLabel ?? '',
                fontSize: widget.formFontSize ?? 12,
                textColor: widget.formTextColor,
                fontWeight: widget.formFontWeight,
                isRequired: widget.formIsRequired ?? false,
              ),
            ],
            IgnorePointer(
              ignoring: widget.isEnabled ? false : true,
              child: DropDownButtonWidget(
                items: widget.item
                    .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: CustomText(
                    text: item,
                    fontSize: widget.fontSize ?? 15,
                    color: widget.textColor ?? Colors.black,
                    fontWeight: widget.fontWeight ?? FontWeight.normal,
                  ),
                )).toList(),
                value: widget.item.contains(widget.value) ? widget.value : null,
                hint: widget.hint,
                searchController: _controller,
                hintSearch: widget.hintSearch,
                isHideDropdownSearchData: widget.isHideDropdownSearchData,
                iconData: widget.iconData,
                iconColor: widget.iconColor,
                isCustomFont: widget.isCustomFont,
                hasUnderline: widget.hasUnderline,
                buttonStylePadding: widget.buttonStylePadding,
                onChanged: widget.onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Region Picker --------------------------------------------------------------
// class FormRegionPicker extends StatefulWidget {
//   const FormRegionPicker({
//     super.key,
//     required this.value,
//     this.fontSize,
//     this.textColor,
//     this.fontWeight,
//     this.isHideDropdownSearchData = false,
//     this.iconData,
//     this.iconColor,
//     this.isEnabled = true,
//     this.isCustomFont = true,
//     this.hasUnderline = false,
//     this.buttonStylePadding,
//     this.visible = true,
//     this.margin = EdgeInsets.zero,
//     this.onChanged,
//
//     /// Form Label
//     this.formLabel,
//     this.formFontSize,
//     this.formTextColor,
//     this.formFontWeight,
//     this.formIsRequired,
//   });
//
//   final String? value;
//
//   final double? fontSize;
//   final Color? textColor;
//   final FontWeight? fontWeight;
//
//   final bool isHideDropdownSearchData;
//
//   final IconData? iconData;
//   final Color? iconColor;
//
//   final bool isEnabled;
//   final bool isCustomFont;
//   final bool hasUnderline;
//   final EdgeInsets? buttonStylePadding;
//
//   final bool visible;
//   final EdgeInsets margin;
//   final Function(String?)? onChanged;
//
//   /// Form Label
//   final String? formLabel;
//   final double? formFontSize;
//   final Color? formTextColor;
//   final FontWeight? formFontWeight;
//   final bool? formIsRequired;
//
//   @override
//   State<FormRegionPicker> createState() => _FormRegionPickerState();
// }
//
// class _FormRegionPickerState extends State<FormRegionPicker> {
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: widget.visible,
//       child: Padding(
//         padding: widget.margin,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (widget.formLabel?.isNotEmpty == true) ...[
//               FormRequiredLabel(
//                 title: widget.formLabel ?? '',
//                 fontSize: widget.formFontSize ?? 12,
//                 textColor: widget.formTextColor,
//                 fontWeight: widget.formFontWeight,
//                 isRequired: widget.formIsRequired ?? false,
//               ),
//             ],
//             BlocBuilder<RegionListCubit, List<PHLocation>?>(
//               builder: (context, region) {
//                 return IgnorePointer(
//                   ignoring: widget.isEnabled ? false : true,
//                   child: DropDownButtonWidget(
//                     items: _removeDuplicates(region!)
//                         .map((PHLocation item) => DropdownMenuItem<String>(
//                       value: item.region,
//                       child: CustomText(
//                         text: item.region ?? '',
//                         fontSize: widget.fontSize ?? 15,
//                         color: widget.textColor ?? (widget.isEnabled ? Colors.black : Colors.grey),
//                         fontWeight: widget.fontWeight ?? FontWeight.normal,
//                       ),
//                     )).toList(),
//                     value: widget.value,
//                     hint: 'Select Region',
//                     searchController: _controller,
//                     hintSearch: 'Search for Region',
//                     isHideDropdownSearchData: widget.isHideDropdownSearchData,
//                     iconData: widget.iconData,
//                     iconColor: widget.iconColor,
//                     isCustomFont: widget.isCustomFont,
//                     hasUnderline: widget.hasUnderline,
//                     buttonStylePadding: widget.buttonStylePadding,
//                     onChanged: widget.onChanged,
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

/// Province Picker ------------------------------------------------------------
// class FormProvincePicker extends StatefulWidget {
//   const FormProvincePicker({
//     super.key,
//     required this.value,
//     this.fontSize,
//     this.textColor,
//     this.fontWeight,
//     this.isHideDropdownSearchData = false,
//     this.iconData,
//     this.iconColor,
//     this.isEnabled = true,
//     this.isCustomFont = true,
//     this.hasUnderline = false,
//     this.buttonStylePadding,
//     this.visible = true,
//     this.margin = EdgeInsets.zero,
//     this.onChanged,
//
//     /// Form Label
//     this.formLabel,
//     this.formFontSize,
//     this.formTextColor,
//     this.formFontWeight,
//     this.formIsRequired,
//   });
//
//   final String? value;
//
//   final double? fontSize;
//   final Color? textColor;
//   final FontWeight? fontWeight;
//
//   final bool isHideDropdownSearchData;
//
//   final IconData? iconData;
//   final Color? iconColor;
//
//   final bool isEnabled;
//   final bool isCustomFont;
//   final bool hasUnderline;
//   final EdgeInsets? buttonStylePadding;
//
//   final bool visible;
//   final EdgeInsets margin;
//   final Function(String?)? onChanged;
//
//   /// Form Label
//   final String? formLabel;
//   final double? formFontSize;
//   final Color? formTextColor;
//   final FontWeight? formFontWeight;
//   final bool? formIsRequired;
//
//   @override
//   State<FormProvincePicker> createState() => _FormProvincePickerState();
// }
//
// class _FormProvincePickerState extends State<FormProvincePicker> {
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: widget.visible,
//       child: Padding(
//         padding: widget.margin,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (widget.formLabel?.isNotEmpty == true) ...[
//               FormRequiredLabel(
//                 title: widget.formLabel ?? '',
//                 fontSize: widget.formFontSize ?? 12,
//                 textColor: widget.formTextColor,
//                 fontWeight: widget.formFontWeight,
//                 isRequired: widget.formIsRequired ?? false,
//               ),
//             ],
//             BlocBuilder<ProvinceListCubit, List<PHLocation>?>(
//               builder: (context, province) {
//                 return IgnorePointer(
//                   ignoring: widget.isEnabled ? false : true,
//                   child: DropDownButtonWidget(
//                     items: province!
//                         .map((PHLocation item) => DropdownMenuItem<String>(
//                       value: item.province,
//                       child: CustomText(
//                         text: item.province ?? '',
//                         fontSize: widget.fontSize ?? 15,
//                         color: widget.textColor ?? (widget.isEnabled ? Colors.black : Colors.grey),
//                         fontWeight: widget.fontWeight ?? FontWeight.normal,
//                       ),
//                     )).toList(),
//                     value: widget.value,
//                     hint: 'Select Province',
//                     searchController: _controller,
//                     hintSearch: 'Search for Province',
//                     isHideDropdownSearchData: widget.isHideDropdownSearchData,
//                     iconData: widget.iconData,
//                     iconColor: widget.iconColor,
//                     isCustomFont: widget.isCustomFont,
//                     hasUnderline: widget.hasUnderline,
//                     buttonStylePadding: widget.buttonStylePadding,
//                     onChanged: widget.onChanged,
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

/// City Picker ----------------------------------------------------------------
// class FormCityPicker extends StatefulWidget {
//   const FormCityPicker({
//     super.key,
//     required this.value,
//     this.fontSize,
//     this.textColor,
//     this.fontWeight,
//     this.isHideDropdownSearchData = false,
//     this.iconData,
//     this.iconColor,
//     this.isEnabled = true,
//     this.isCustomFont = true,
//     this.hasUnderline = false,
//     this.buttonStylePadding,
//     this.visible = true,
//     this.margin = EdgeInsets.zero,
//     this.onChanged,
//
//     /// Form Label
//     this.formLabel,
//     this.formFontSize,
//     this.formTextColor,
//     this.formFontWeight,
//     this.formIsRequired,
//   });
//
//   final String? value;
//
//   final double? fontSize;
//   final Color? textColor;
//   final FontWeight? fontWeight;
//
//   final bool isHideDropdownSearchData;
//
//   final IconData? iconData;
//   final Color? iconColor;
//
//   final bool isEnabled;
//   final bool isCustomFont;
//   final bool hasUnderline;
//   final EdgeInsets? buttonStylePadding;
//
//   final bool visible;
//   final EdgeInsets margin;
//   final Function(String?)? onChanged;
//
//   /// Form Label
//   final String? formLabel;
//   final double? formFontSize;
//   final Color? formTextColor;
//   final FontWeight? formFontWeight;
//   final bool? formIsRequired;
//
//   @override
//   State<FormCityPicker> createState() => _FormCityPickerState();
// }
//
// class _FormCityPickerState extends State<FormCityPicker> {
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: widget.visible,
//       child: Padding(
//         padding: widget.margin,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (widget.formLabel?.isNotEmpty == true) ...[
//               FormRequiredLabel(
//                 title: widget.formLabel ?? '',
//                 fontSize: widget.formFontSize ?? 12,
//                 textColor: widget.formTextColor,
//                 fontWeight: widget.formFontWeight,
//                 isRequired: widget.formIsRequired ?? false,
//               ),
//             ],
//             BlocBuilder<CityListCubit, List<PHLocation>?>(
//               builder: (context, city) {
//                 return IgnorePointer(
//                   ignoring: widget.isEnabled ? false : true,
//                   child: DropDownButtonWidget(
//                     items: city!
//                         .map((PHLocation item) => DropdownMenuItem<String>(
//                       value: item.city_municipality,
//                       child: CustomText(
//                         text: item.city_municipality ?? '',
//                         fontSize: widget.fontSize ?? 15,
//                         color: widget.textColor ?? (widget.isEnabled ? Colors.black : Colors.grey),
//                         fontWeight: widget.fontWeight ?? FontWeight.normal,
//                       ),
//                     )).toList(),
//                     value: widget.value,
//                     hint: 'Select City/Municipality',
//                     searchController: _controller,
//                     hintSearch: 'Search for City/Municipality',
//                     isHideDropdownSearchData: widget.isHideDropdownSearchData,
//                     iconData: widget.iconData,
//                     iconColor: widget.iconColor,
//                     isCustomFont: widget.isCustomFont,
//                     hasUnderline: widget.hasUnderline,
//                     buttonStylePadding: widget.buttonStylePadding,
//                     onChanged: widget.onChanged,
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

/// Barangay Picker ------------------------------------------------------------
// class FormBarangayPicker extends StatefulWidget {
//   const FormBarangayPicker({
//     super.key,
//     required this.value,
//     this.fontSize,
//     this.textColor,
//     this.fontWeight,
//     this.isHideDropdownSearchData = false,
//     this.iconData,
//     this.iconColor,
//     this.isEnabled = true,
//     this.isCustomFont = true,
//     this.hasUnderline = false,
//     this.buttonStylePadding,
//     this.visible = true,
//     this.margin = EdgeInsets.zero,
//     this.onChanged,
//
//     /// Form Label
//     this.formLabel,
//     this.formFontSize,
//     this.formTextColor,
//     this.formFontWeight,
//     this.formIsRequired,
//   });
//
//   final String? value;
//
//   final double? fontSize;
//   final Color? textColor;
//   final FontWeight? fontWeight;
//
//   final bool isHideDropdownSearchData;
//
//   final IconData? iconData;
//   final Color? iconColor;
//
//   final bool isEnabled;
//   final bool isCustomFont;
//   final bool hasUnderline;
//   final EdgeInsets? buttonStylePadding;
//
//   final bool visible;
//   final EdgeInsets margin;
//   final Function(String?)? onChanged;
//
//   /// Form Label
//   final String? formLabel;
//   final double? formFontSize;
//   final Color? formTextColor;
//   final FontWeight? formFontWeight;
//   final bool? formIsRequired;
//
//   @override
//   State<FormBarangayPicker> createState() => _FormBarangayPickerState();
// }
//
// class _FormBarangayPickerState extends State<FormBarangayPicker> {
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: widget.visible,
//       child: Padding(
//         padding: widget.margin,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (widget.formLabel?.isNotEmpty == true) ...[
//               FormRequiredLabel(
//                 title: widget.formLabel ?? '',
//                 fontSize: widget.formFontSize ?? 12,
//                 textColor: widget.formTextColor,
//                 fontWeight: widget.formFontWeight,
//                 isRequired: widget.formIsRequired ?? false,
//               ),
//             ],
//             BlocBuilder<BarangayListCubit, List<PHLocation>?>(
//               builder: (context, barangay) {
//                 return IgnorePointer(
//                   ignoring: widget.isEnabled ? false : true,
//                   child: DropDownButtonWidget(
//                     items: barangay!
//                         .map((PHLocation item) => DropdownMenuItem<String>(
//                       value: item.barangay,
//                       child: CustomText(
//                         text: item.barangay ?? '',
//                         fontSize: widget.fontSize ?? 15,
//                         color: widget.textColor ?? (widget.isEnabled ? Colors.black : Colors.grey),
//                         fontWeight: widget.fontWeight ?? FontWeight.normal,
//                       ),
//                     )).toList(),
//                     value: widget.value,
//                     hint: 'Select Barangay',
//                     searchController: _controller,
//                     hintSearch: 'Search for Barangay',
//                     isHideDropdownSearchData: widget.isHideDropdownSearchData,
//                     iconData: widget.iconData,
//                     iconColor: widget.iconColor,
//                     isCustomFont: widget.isCustomFont,
//                     hasUnderline: widget.hasUnderline,
//                     buttonStylePadding: widget.buttonStylePadding,
//                     onChanged: widget.onChanged,
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


