import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '_widget.dart';

class DynamicCheckboxList extends StatelessWidget {
  final List<String> items;
  final List<String> selectedItems; // controlled from parent
  final Color tileColor;
  final Color activeColor;
  final Color borderColor;
  final dynamic Function(List<String>)? onChanged;

  const DynamicCheckboxList({
    super.key,
    required this.items,
    required this.selectedItems,
    this.tileColor = Colors.white,
    this.activeColor = Colors.orange,
    this.borderColor = Colors.grey,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = items[index];
        final isChecked = selectedItems.contains(item);

        return CheckboxListTile(
          dense: true,
          tileColor: tileColor,
          side: BorderSide(color: borderColor, width: 2),
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          activeColor: activeColor,
          value: isChecked,
          onChanged: (value) {
            final updated = List<String>.from(selectedItems);
            if (value == true) {
              updated.add(item);
            } else {
              updated.remove(item);
            }
            onChanged?.call(updated);
          },
          title: CustomText(
            text: item,
            fontSize: 14,
            color: Colors.black87,
          ),
        );
      },
    );
  }
}

/// ----------------------------------------------------------------------------
class DynamicCheckboxWithOthersList extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems; // controlled from parent
  final Color tileColor;
  final Color activeColor;
  final Color borderColor;
  final Function(List<String>)? onChanged; // only returns list

  const DynamicCheckboxWithOthersList({
    super.key,
    required this.items,
    required this.selectedItems,
    this.tileColor = Colors.white,
    this.activeColor = Colors.orange,
    this.borderColor = Colors.grey,
    this.onChanged,
  });

  @override
  State<DynamicCheckboxWithOthersList> createState() =>
      _DynamicCheckboxWithOthersListState();
}

class _DynamicCheckboxWithOthersListState extends State<DynamicCheckboxWithOthersList> {
  late TextEditingController _otherController;

  @override
  void initState() {
    super.initState();

    // Get existing custom "Others" value from selectedItems
    final existingOther = widget.selectedItems.firstWhere(
          (val) => !widget.items.contains(val),
      orElse: () => "",
    );

    _otherController = TextEditingController(text: existingOther);
  }

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }

  void _handleCheckboxChanged(String item, bool? value) {
    final updated = List<String>.from(widget.selectedItems);

    if (item == "Others") {
      if (value == true) {
        if (_otherController.text.isNotEmpty) {
          updated.add(_otherController.text);
        } else {
          updated.add("Others");
        }
      } else {
        updated.remove("Others");
        updated.removeWhere((val) => !widget.items.contains(val));
      }
    } else {
      if (value == true) {
        updated.add(item);
      } else {
        updated.remove(item);
      }
    }

    widget.onChanged?.call(updated);
  }

  void _handleOtherTextChanged(String val) {
    final updated = List<String>.from(widget.selectedItems);

    // Remove old "Others" placeholder or custom text
    updated.remove("Others");
    updated.removeWhere((v) => !widget.items.contains(v));

    if (val.isNotEmpty) {
      updated.add(val); // add typed custom value
    } else {
      updated.add("Others"); // fallback placeholder
    }

    widget.onChanged?.call(updated);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final isOther = item == "Others";

        // Look for custom text stored in selectedItems
        final existingOther = widget.selectedItems.firstWhere(
              (val) => !widget.items.contains(val),
          orElse: () => "",
        );

        final isChecked = isOther
            ? widget.selectedItems.contains("Others") ||
            existingOther.isNotEmpty
            : widget.selectedItems.contains(item);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              dense: true,
              tileColor: widget.tileColor,
              side: BorderSide(color: widget.borderColor, width: 2),
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              visualDensity:
              const VisualDensity(horizontal: -4, vertical: -4),
              activeColor: widget.activeColor,
              value: isChecked,
              onChanged: (value) => _handleCheckboxChanged(item, value),
              title: CustomText(
                text: item,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            if (isOther && isChecked)
              Padding(
                padding: const EdgeInsets.only(left: 40.0, bottom: 8.0),
                child: TextField(
                  controller: _otherController,
                  decoration: InputDecoration(
                    labelText: "Please specify",
                    labelStyle: GoogleFonts.poppins(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: .5),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 1),
                    ),
                  ),
                  onChanged: _handleOtherTextChanged,
                ),
              ),
          ],
        );
      },
    );
  }
}



