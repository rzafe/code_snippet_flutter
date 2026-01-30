import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// import '../../bloc/common/_common.dart';
import '../../data/model/_model.dart';
import '../../utilities/_utils.dart';
import '_widget.dart';

// List<PHLocation> _removeDuplicates(List<PHLocation> items) {
//   List<PHLocation> uniqueItems = [];
//
//   /// uniqueList
//   var uniqueIDs = items.map((e) => e.region).toSet();
//
//   /// list if UniqueID to remove duplicates
//   for (var e in uniqueIDs) {
//     uniqueItems.add(items.firstWhere((i) => i.region == e));
//   }
//
//   /// populate uniqueItems with equivalent original Batch items
//   return uniqueItems;
//
//   ///send back the unique items list
// }

/// DropDown Button Widget -----------------------------------------------------
class DropDownButtonWidget extends StatelessWidget {
  const DropDownButtonWidget({
    super.key,
    required this.items,
    required this.value,
    this.hint,
    this.hintSearch,
    required this.searchController,
    this.hintFontSize,
    this.hintTextColor,
    this.iconColor,
    this.iconData,
    this.isCustomFont = true,
    this.isHideDropdownSearchData = false,
    this.hasUnderline = false,
    this.buttonStylePadding,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onChanged,
  });

  final dynamic items;
  final String? value;
  final String? hint;
  final String? hintSearch;
  final TextEditingController searchController;
  final double? hintFontSize;
  final Color? hintTextColor;
  final Color? iconColor;
  final IconData? iconData;
  final bool isCustomFont;
  final bool isHideDropdownSearchData;
  final bool hasUnderline;
  final EdgeInsets? buttonStylePadding;
  final bool visible;
  final EdgeInsets margin;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            barrierColor: Colors.black.withValues(alpha: .1),
            hint: CustomText(
              title: hint ?? '',
              fontSize: hintFontSize ?? 15,
              textColor: hintTextColor ?? Colors.grey,
              textAlign: TextAlign.start,
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
              decoration: hasUnderline
                  ? BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    )
                  : BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
              elevation: 0,
            ),
            items: items,
            value: value,
            onChanged: onChanged,
            dropdownStyleData: DropdownStyleData(
              maxHeight: height * .5,
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
            dropdownSearchData: isHideDropdownSearchData == true ? null : DropdownSearchData(
              searchController: searchController,
              searchInnerWidgetHeight: 60,
              searchInnerWidget: Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                height: height * .08,
                child: TextFormField(
                  expands: true,
                  maxLines: null,
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
                return item.value.toString().toUpperCase().contains(searchValue.toUpperCase());
              },
            ),
            /// This to clear the search value when you close the menu
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
    this.hint,
    this.hintSearch,
    this.fontSize,
    this.textColor,
    this.fontWeight,
    this.iconData,
    this.iconColor,
    this.isEnabled = true,
    this.isHideDropdownSearchData = false,
    this.isCustomFont = true,
    this.hasUnderline = false,
    this.buttonStylePadding,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onChanged,
  });

  final List<String> item;
  final String? value;
  final String? hint;
  final String? hintSearch;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final IconData? iconData;
  final Color? iconColor;
  final bool isEnabled;
  final bool isHideDropdownSearchData;
  final bool isCustomFont;
  final bool hasUnderline;
  final EdgeInsets? buttonStylePadding;
  final bool visible;
  final EdgeInsets margin;
  final Function(String?)? onChanged;

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
        child: IgnorePointer(
          ignoring: widget.isEnabled ? false : true,
          child: DropDownButtonWidget(
            items: widget.item
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: CustomText(
                title: item,
                fontSize: widget.fontSize ?? 15,
                textColor: widget.textColor ?? Colors.black,
                fontWeight: widget.fontWeight ?? FontWeight.normal,
              ),
            )).toList(),
            value: widget.item.contains(widget.value) ? widget.value : null,
            hint: widget.hint,
            hintSearch: widget.hintSearch,
            iconData: widget.iconData,
            iconColor: widget.iconColor,
            searchController: _controller,
            isHideDropdownSearchData: widget.isHideDropdownSearchData,
            isCustomFont: widget.isCustomFont,
            hasUnderline: widget.hasUnderline,
            buttonStylePadding: widget.buttonStylePadding,
            onChanged: widget.onChanged,
          ),
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
//     this.iconData,
//     this.iconColor,
//     this.isEnabled = true,
//     this.isHideDropdownSearchData = false,
//     this.isCustomFont = true,
//     this.hasUnderline = false,
//     this.buttonStylePadding,
//     this.visible = true,
//     this.margin = EdgeInsets.zero,
//     this.onChanged,
//   });
//
//   final String? value;
//   final IconData? iconData;
//   final Color? iconColor;
//   final bool isEnabled;
//   final bool isHideDropdownSearchData;
//   final bool isCustomFont;
//   final bool hasUnderline;
//   final EdgeInsets? buttonStylePadding;
//   final bool visible;
//   final EdgeInsets margin;
//   final Function(String?)? onChanged;
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
//         child: BlocBuilder<RegionListCubit, List<PHLocation>?>(
//           builder: (context, region) {
//             return IgnorePointer(
//               ignoring: widget.isEnabled ? false : true,
//               child: DropDownButtonWidget(
//                 items: _removeDuplicates(region!)
//                     .map((PHLocation item) => DropdownMenuItem<String>(
//                   value: item.region,
//                   child: CustomText(
//                     title: item.region ?? '',
//                     fontSize: 15,
//                     textColor: widget.isEnabled ? Colors.black : Colors.grey,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 )).toList(),
//                 value: widget.value,
//                 hint: 'Select Region',
//                 hintSearch: 'Search for Region',
//                 iconData: widget.iconData,
//                 iconColor: widget.iconColor,
//                 searchController: _controller,
//                 isHideDropdownSearchData: widget.isHideDropdownSearchData,
//                 isCustomFont: widget.isCustomFont,
//                 hasUnderline: widget.hasUnderline,
//                 buttonStylePadding: widget.buttonStylePadding,
//                 onChanged: widget.onChanged,
//               ),
//             );
//           },
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
//     this.iconData,
//     this.iconColor,
//     this.isEnabled = true,
//     this.isHideDropdownSearchData = false,
//     this.isCustomFont = true,
//     this.hasUnderline = false,
//     this.buttonStylePadding,
//     this.visible = true,
//     this.margin = EdgeInsets.zero,
//     this.onChanged,
//   });
//
//   final String? value;
//   final IconData? iconData;
//   final Color? iconColor;
//   final bool isEnabled;
//   final bool isHideDropdownSearchData;
//   final bool isCustomFont;
//   final bool hasUnderline;
//   final EdgeInsets? buttonStylePadding;
//   final bool visible;
//   final EdgeInsets margin;
//   final Function(String?)? onChanged;
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
//         child: BlocBuilder<ProvinceListCubit, List<PHLocation>?>(
//           builder: (context, province) {
//             return IgnorePointer(
//               ignoring: widget.isEnabled ? false : true,
//               child: DropDownButtonWidget(
//                 items: province!
//                     .map((PHLocation item) => DropdownMenuItem<String>(
//                   value: item.province,
//                   child: CustomText(
//                     title: item.province ?? '',
//                     fontSize: 15,
//                     textColor: widget.isEnabled ? Colors.black : Colors.grey,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 )).toList(),
//                 value: widget.value,
//                 hint: 'Select Province',
//                 hintSearch: 'Search for Province',
//                 iconData: widget.iconData,
//                 iconColor: widget.iconColor,
//                 searchController: _controller,
//                 isHideDropdownSearchData: widget.isHideDropdownSearchData,
//                 isCustomFont: widget.isCustomFont,
//                 hasUnderline: widget.hasUnderline,
//                 buttonStylePadding: widget.buttonStylePadding,
//                 onChanged: widget.onChanged,
//               ),
//             );
//           },
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
//     this.iconData,
//     this.iconColor,
//     this.isEnabled = true,
//     this.isHideDropdownSearchData = false,
//     this.isCustomFont = true,
//     this.hasUnderline = false,
//     this.buttonStylePadding,
//     this.visible = true,
//     this.margin = EdgeInsets.zero,
//     this.onChanged,
//   });
//
//   final String? value;
//   final IconData? iconData;
//   final Color? iconColor;
//   final bool isEnabled;
//   final bool isHideDropdownSearchData;
//   final bool isCustomFont;
//   final bool hasUnderline;
//   final EdgeInsets? buttonStylePadding;
//   final bool visible;
//   final EdgeInsets margin;
//   final Function(String?)? onChanged;
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
//         child: BlocBuilder<CityListCubit, List<PHLocation>?>(
//           builder: (context, city) {
//             return IgnorePointer(
//               ignoring: widget.isEnabled ? false : true,
//               child: DropDownButtonWidget(
//                 items: city!
//                     .map((PHLocation item) => DropdownMenuItem<String>(
//                   value: item.city_municipality,
//                   child: CustomText(
//                     title: item.city_municipality ?? '',
//                     fontSize: 15,
//                     textColor: widget.isEnabled ? Colors.black : Colors.grey,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 )).toList(),
//                 value: widget.value,
//                 hint: 'Select City/Municipality',
//                 hintSearch: 'Search for City/Municipality',
//                 iconData: widget.iconData,
//                 iconColor: widget.iconColor,
//                 searchController: _controller,
//                 isHideDropdownSearchData: widget.isHideDropdownSearchData,
//                 isCustomFont: widget.isCustomFont,
//                 hasUnderline: widget.hasUnderline,
//                 buttonStylePadding: widget.buttonStylePadding,
//                 onChanged: widget.onChanged,
//               ),
//             );
//           },
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
//     this.iconData,
//     this.iconColor,
//     this.isEnabled = true,
//     this.isHideDropdownSearchData = false,
//     this.isCustomFont = true,
//     this.hasUnderline = false,
//     this.buttonStylePadding,
//     this.visible = true,
//     this.margin = EdgeInsets.zero,
//     this.onChanged,
//   });
//
//   final String? value;
//   final IconData? iconData;
//   final Color? iconColor;
//   final bool isEnabled;
//   final bool isHideDropdownSearchData;
//   final bool isCustomFont;
//   final bool hasUnderline;
//   final EdgeInsets? buttonStylePadding;
//   final bool visible;
//   final EdgeInsets margin;
//   final Function(String?)? onChanged;
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
//         child: BlocBuilder<BarangayListCubit, List<PHLocation>?>(
//           builder: (context, barangay) {
//             return IgnorePointer(
//               ignoring: widget.isEnabled ? false : true,
//               child: DropDownButtonWidget(
//                 items: barangay!
//                     .map((PHLocation item) => DropdownMenuItem<String>(
//                   value: item.barangay,
//                   child: CustomText(
//                     title: item.barangay ?? '',
//                     fontSize: 15,
//                     textColor: widget.isEnabled ? Colors.black : Colors.grey,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 )).toList(),
//                 value: widget.value,
//                 hint: 'Select Barangay',
//                 hintSearch: 'Search for Barangay',
//                 iconData: widget.iconData,
//                 iconColor: widget.iconColor,
//                 searchController: _controller,
//                 isHideDropdownSearchData: widget.isHideDropdownSearchData,
//                 isCustomFont: widget.isCustomFont,
//                 hasUnderline: widget.hasUnderline,
//                 buttonStylePadding: widget.buttonStylePadding,
//                 onChanged: widget.onChanged,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

/// Gender Picker --------------------------------------------------------------
class FormGenderPicker extends StatefulWidget {
  const FormGenderPicker({
    super.key,
    required this.value,
    this.hint = 'Choose Gender',
    this.isEnabled = true,
    this.isHideDropdownSearchData = false,
    this.hasUnderline = false,
    this.buttonStylePadding,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onChanged,
  });

  final String? value;
  final String hint;
  final bool isEnabled;
  final bool isHideDropdownSearchData;
  final bool hasUnderline;
  final EdgeInsets? buttonStylePadding;
  final bool visible;
  final EdgeInsets margin;
  final Function(String?)? onChanged;

  @override
  State<FormGenderPicker> createState() => _FormGenderPickerState();
}

class _FormGenderPickerState extends State<FormGenderPicker> {
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
        child: IgnorePointer(
          ignoring: widget.isEnabled ? false : true,
          child: DropDownButtonWidget(
            items: genderList
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: widget.isEnabled ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ))
                .toList(),
            value: genderList.contains(widget.value) ? widget.value : null,
            hint: widget.hint,
            hintSearch: 'Search for Gender',
            searchController: _controller,
            isHideDropdownSearchData: widget.isHideDropdownSearchData,
            hasUnderline: widget.hasUnderline,
            buttonStylePadding: widget.buttonStylePadding,
            onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }
}

/// EmploymentType Picker ------------------------------------------------------
class FormEmploymentTypePicker extends StatefulWidget {
  const FormEmploymentTypePicker({
    super.key,
    required this.value,
    this.hint = 'Select Employment Status',
    this.isEnabled = true,
    this.isHideDropdownSearchData = false,
    this.hasUnderline = false,
    this.buttonStylePadding,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onChanged,
  });

  final String? value;
  final String hint;
  final bool isEnabled;
  final bool isHideDropdownSearchData;
  final bool hasUnderline;
  final EdgeInsets? buttonStylePadding;
  final bool visible;
  final EdgeInsets margin;
  final Function(String?)? onChanged;

  @override
  State<FormEmploymentTypePicker> createState() => _FormEmploymentTypePickerState();
}

class _FormEmploymentTypePickerState extends State<FormEmploymentTypePicker> {
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
        child: IgnorePointer(
          ignoring: widget.isEnabled ? false : true,
          child: DropDownButtonWidget(
            items: employmentStatusList
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: widget.isEnabled ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            )).toList(),
            value: employmentStatusList.contains(widget.value) ? widget.value : null,
            hint: widget.hint,
            hintSearch: 'Search for Employment Status',
            searchController: _controller,
            isHideDropdownSearchData: widget.isHideDropdownSearchData,
            hasUnderline: widget.hasUnderline,
            buttonStylePadding: widget.buttonStylePadding,
            onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }
}

/// Religion Picker ------------------------------------------------------------
class FormReligionPicker extends StatefulWidget {
  const FormReligionPicker({
    super.key,
    required this.value,
    this.hint = 'Select Religion',
    this.isEnabled = true,
    this.isHideDropdownSearchData = false,
    this.hasUnderline = false,
    this.buttonStylePadding,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onChanged,
  });

  final String? value;
  final String hint;
  final bool isEnabled;
  final bool isHideDropdownSearchData;
  final bool hasUnderline;
  final EdgeInsets? buttonStylePadding;
  final bool visible;
  final EdgeInsets margin;
  final Function(String?)? onChanged;

  @override
  State<FormReligionPicker> createState() => _FormReligionPickerState();
}

class _FormReligionPickerState extends State<FormReligionPicker> {
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
        child: IgnorePointer(
          ignoring: !widget.isEnabled,
          child: DropDownButtonWidget(
            items: religionList
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: widget.isEnabled ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ))
                .toList(),
            value: religionList.contains(widget.value) ? widget.value : null,
            hint: widget.hint,
            hintSearch: 'Search for Religion',
            searchController: _controller,
            isHideDropdownSearchData: widget.isHideDropdownSearchData,
            hasUnderline: widget.hasUnderline,
            buttonStylePadding: widget.buttonStylePadding,
            onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }
}

/// Classification Picker with Pension Dropdown --------------------------------
class FormClassificationPicker extends StatefulWidget {
  const FormClassificationPicker({
    super.key,
    required this.classificationValue,
    this.pensionValue,
    this.hintClassification = 'Select Classification',
    this.hintPension = 'Select Pension Range',
    this.isEnabled = true,
    this.margin = EdgeInsets.zero,
    this.onClassificationChanged,
    this.onPensionChanged,
  });

  final String? classificationValue;
  final String? pensionValue;
  final String hintClassification;
  final String hintPension;
  final bool isEnabled;
  final EdgeInsets margin;
  final Function(String?)? onClassificationChanged;
  final Function(String?)? onPensionChanged;

  @override
  State<FormClassificationPicker> createState() => _FormClassificationPickerState();
}

class _FormClassificationPickerState extends State<FormClassificationPicker> {
  final TextEditingController _classificationController = TextEditingController();
  final TextEditingController _pensionController = TextEditingController();

  @override
  void dispose() {
    _classificationController.dispose();
    _pensionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPensioner = widget.classificationValue == 'Pensioner';

    return Padding(
      padding: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Classification Dropdown
          DropDownButtonWidget(
            items: classificationList
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: widget.isEnabled ? Colors.black : Colors.grey,
                ),
              ),
            ))
                .toList(),
            value: classificationList.contains(widget.classificationValue)
                ? widget.classificationValue
                : null,
            hint: widget.hintClassification,
            hintSearch: 'Search for Classification',
            searchController: _classificationController,
            onChanged: (value) {
              widget.onClassificationChanged?.call(value);

              // Reset pension when classification changes
              if (value != 'Pensioner') {
                widget.onPensionChanged?.call(null);
              }
            },
          ),

          /// Pension Dropdown (only visible when "Pensioner" selected)
          if (isPensioner) ...[
            const SizedBox(height: 10),
            DropDownButtonWidget(
              items: pensionRangeList
                  .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: widget.isEnabled ? Colors.black : Colors.grey,
                  ),
                ),
              ))
                  .toList(),
              value: pensionRangeList.contains(widget.pensionValue)
                  ? widget.pensionValue
                  : null,
              hint: widget.hintPension,
              hintSearch: 'Search for Pension Range',
              searchController: _pensionController,
              onChanged: widget.onPensionChanged,
            ),
          ],
        ],
      ),
    );
  }
}

/// BloodType Picker -----------------------------------------------------------
class FormBloodTyePicker extends StatefulWidget {
  const FormBloodTyePicker({
    super.key,
    required this.value,
    this.hint = 'Select Blood Type',
    this.isEnabled = true,
    this.isHideDropdownSearchData = false,
    this.hasUnderline = false,
    this.buttonStylePadding,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onChanged,
  });

  final String? value;
  final String hint;
  final bool isEnabled;
  final bool isHideDropdownSearchData;
  final bool hasUnderline;
  final EdgeInsets? buttonStylePadding;
  final bool visible;
  final EdgeInsets margin;
  final Function(String?)? onChanged;

  @override
  State<FormBloodTyePicker> createState() => _FormBloodTyePickerState();
}

class _FormBloodTyePickerState extends State<FormBloodTyePicker> {
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
        child: IgnorePointer(
          ignoring: widget.isEnabled ? false : true,
          child: DropDownButtonWidget(
            items: bloodTypeList
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: widget.isEnabled ? Colors.black : Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ))
                .toList(),
// value: widget.value,
            value: bloodTypeList.contains(widget.value) ? widget.value : null,
            hint: widget.hint,
            hintSearch: 'Search for Blood Type',
            searchController: _controller,
            isHideDropdownSearchData: widget.isHideDropdownSearchData,
            hasUnderline: widget.hasUnderline,
            buttonStylePadding: widget.buttonStylePadding,
            onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }
}

/// ApplicationCategory Picker -------------------------------------------------
class FormApplicationCategoryPicker extends StatefulWidget {
  const FormApplicationCategoryPicker({
    super.key,
    required this.value,
    this.hint = 'Select Application Category',
    this.isEnabled = true,
    this.isHideDropdownSearchData = false,
    this.hasUnderline = false,
    this.buttonStylePadding,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onChanged,
  });

  final String? value;
  final String hint;
  final bool isEnabled;
  final bool isHideDropdownSearchData;
  final bool hasUnderline;
  final EdgeInsets? buttonStylePadding;
  final bool visible;
  final EdgeInsets margin;
  final Function(String?)? onChanged;

  @override
  State<FormApplicationCategoryPicker> createState() => _FormApplicationCategoryPickerState();
}

class _FormApplicationCategoryPickerState extends State<FormApplicationCategoryPicker> {
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
        child: IgnorePointer(
          ignoring: widget.isEnabled ? false : true,
          child: DropDownButtonWidget(
            items: genderList
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: widget.isEnabled ? Colors.black : Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ))
                .toList(),
// value: widget.value,
            value: genderList.contains(widget.value) ? widget.value : null,
            hint: widget.hint,
            hintSearch: 'Search for Application Category',
            searchController: _controller,
            isHideDropdownSearchData: widget.isHideDropdownSearchData,
            hasUnderline: widget.hasUnderline,
            buttonStylePadding: widget.buttonStylePadding,
            onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }
}

/// Type Assistance Picker -----------------------------------------------------
class FormTypeAssistancePicker extends StatefulWidget {
  const FormTypeAssistancePicker({
    super.key,
    required this.value,
    this.hint = 'Type of Assistance',
    this.isEnabled = true,
    this.isHideDropdownSearchData = false,
    this.hasUnderline = false,
    this.buttonStylePadding,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onChanged,
  });

  final String? value;
  final String hint;
  final bool isEnabled;
  final bool isHideDropdownSearchData;
  final bool hasUnderline;
  final EdgeInsets? buttonStylePadding;
  final bool visible;
  final EdgeInsets margin;
  final Function(String?)? onChanged;

  @override
  State<FormTypeAssistancePicker> createState() => _FormTypeAssistancePickerState();
}

class _FormTypeAssistancePickerState extends State<FormTypeAssistancePicker> {
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
        child: IgnorePointer(
          ignoring: widget.isEnabled ? false : true,
          child: DropDownButtonWidget(
            items: assistanceMedicalOptions
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: widget.isEnabled ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ))
                .toList(),
            // value: widget.value,
            value: assistanceMedicalOptions.contains(widget.value) ? widget.value : null,
            hint: widget.hint,
            hintSearch: 'Search for Type Assistance',
            searchController: _controller,
            isHideDropdownSearchData: widget.isHideDropdownSearchData,
            hasUnderline: widget.hasUnderline,
            buttonStylePadding: widget.buttonStylePadding,
            onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }
}

/// Assisted By Picker ---------------------------------------------------------
class FormAssistedByPicker extends StatefulWidget {
  const FormAssistedByPicker({
    super.key,
    required this.value,
    this.hint = 'Assisted By',
    this.isEnabled = true,
    this.isHideDropdownSearchData = false,
    this.hasUnderline = false,
    this.buttonStylePadding,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onChanged,
  });

  final String? value;
  final String hint;
  final bool isEnabled;
  final bool isHideDropdownSearchData;
  final bool hasUnderline;
  final EdgeInsets? buttonStylePadding;
  final bool visible;
  final EdgeInsets margin;
  final Function(String?)? onChanged;

  @override
  State<FormAssistedByPicker> createState() => _FormAssistedByPickerState();
}

class _FormAssistedByPickerState extends State<FormAssistedByPicker> {
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
        child: IgnorePointer(
          ignoring: widget.isEnabled ? false : true,
          child: DropDownButtonWidget(
            items: assistedByOptions
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: widget.isEnabled ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ))
                .toList(),
            // value: widget.value,
            value: assistedByOptions.contains(widget.value) ? widget.value : null,
            hint: widget.hint,
            hintSearch: 'Search for Type Assistance',
            searchController: _controller,
            isHideDropdownSearchData: widget.isHideDropdownSearchData,
            hasUnderline: widget.hasUnderline,
            buttonStylePadding: widget.buttonStylePadding,
            onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }
}

/// Civil Status ---------------------------------------------------------------
class FormCivilStatusPicker extends StatefulWidget {
  const FormCivilStatusPicker({
    super.key,
    required this.value,
    this.hint = 'Select Civil Status',
    this.isEnabled = true,
    this.isHideDropdownSearchData = false,
    this.hasUnderline = false,
    this.buttonStylePadding,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onChanged,
  });

  final String? value;
  final String hint;
  final bool isEnabled;
  final bool isHideDropdownSearchData;
  final bool hasUnderline;
  final EdgeInsets? buttonStylePadding;
  final bool visible;
  final EdgeInsets margin;
  final Function(String?)? onChanged;

  @override
  State<FormCivilStatusPicker> createState() => _FormCivilStatusPickerState();
}

class _FormCivilStatusPickerState extends State<FormCivilStatusPicker> {
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
        child: IgnorePointer(
          ignoring: widget.isEnabled ? false : true,
          child: DropDownButtonWidget(
            items: civilStatusList
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: widget.isEnabled ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ))
                .toList(),
            // value: widget.value,
            value: civilStatusList.contains(widget.value) ? widget.value : null,
            hint: widget.hint,
            hintSearch: 'Search for Civil Status',
            searchController: _controller,
            isHideDropdownSearchData: widget.isHideDropdownSearchData,
            hasUnderline: widget.hasUnderline,
            buttonStylePadding: widget.buttonStylePadding,
            onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }
}

/// SCHOOL SECTOR --------------------------------------------------------------
class FormSchoolSectorPicker extends StatefulWidget {
  const FormSchoolSectorPicker({
    super.key,
    required this.value,
    this.hint = 'Select School Sector',
    this.isEnabled = true,
    this.isHideDropdownSearchData = false,
    this.hasUnderline = false,
    this.buttonStylePadding,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onChanged,
  });

  final String? value;
  final String hint;
  final bool isEnabled;
  final bool isHideDropdownSearchData;
  final bool hasUnderline;
  final EdgeInsets? buttonStylePadding;
  final bool visible;
  final EdgeInsets margin;
  final Function(String?)? onChanged;

  @override
  State<FormSchoolSectorPicker> createState() => _FormSchoolSectorPickerState();
}

class _FormSchoolSectorPickerState extends State<FormSchoolSectorPicker> {
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
        child: IgnorePointer(
          ignoring: widget.isEnabled ? false : true,
          child: DropDownButtonWidget(
            items: schoolSectorList
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: widget.isEnabled ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ))
                .toList(),
            // value: widget.value,
            isHideDropdownSearchData: widget.isHideDropdownSearchData,
            value: schoolSectorList.contains(widget.value) ? widget.value : null,
            hint: widget.hint,
            hasUnderline: widget.hasUnderline,
            buttonStylePadding: widget.buttonStylePadding,
            onChanged: widget.onChanged,
            searchController: _controller,
          ),
        ),
      ),
    );
  }
}

/// Education Attainment -------------------------------------------------------
class FormEducAttainPicker extends StatefulWidget {
  const FormEducAttainPicker({
    super.key,
    required this.value,
    this.hint = 'Select Education Attainment',
    this.isEnabled = true,
    this.isHideDropdownSearchData = false,
    this.hasUnderline = false,
    this.buttonStylePadding,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onChanged,
  });

  final String? value;
  final String hint;
  final bool isEnabled;
  final bool isHideDropdownSearchData;
  final bool hasUnderline;
  final EdgeInsets? buttonStylePadding;
  final bool visible;
  final EdgeInsets margin;
  final Function(String?)? onChanged;

  @override
  State<FormEducAttainPicker> createState() => _FormEducAttainPickerState();
}

class _FormEducAttainPickerState extends State<FormEducAttainPicker> {
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
        child: IgnorePointer(
          ignoring: widget.isEnabled ? false : true,
          child: DropDownButtonWidget(
            items: educationAttainmentList
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: widget.isEnabled ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ))
                .toList(),
            // value: widget.value,
            value: educationAttainmentList.contains(widget.value) ? widget.value : null,
            hint: widget.hint,
            hintSearch: 'Search for Education Attainment',
            searchController: _controller,
            isHideDropdownSearchData: widget.isHideDropdownSearchData,
            hasUnderline: widget.hasUnderline,
            buttonStylePadding: widget.buttonStylePadding,
            onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }
}
