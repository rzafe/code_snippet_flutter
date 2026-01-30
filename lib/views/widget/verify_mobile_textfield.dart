import 'package:flutter/material.dart';

import '../../utilities/_utils.dart';
import '_widget.dart';

class VerifyMobileTextField extends StatelessWidget {
  const VerifyMobileTextField({
    super.key,
    required this.controller,
    this.readOnly = false,
    this.backgroundColor,
    this.codeBorderColor,
    this.onTapClear,
    this.onChanged,
    this.visible = true,
    this.margin = EdgeInsets.zero,
  });

  final TextEditingController controller;
  final bool readOnly;
  final Color? backgroundColor;
  final Color? codeBorderColor;
  final Function()? onTapClear;
  final Function(String)? onChanged;
  final bool visible;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 1),
              height: 55,
              decoration: BoxDecoration(
                color: backgroundColor ?? Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: codeBorderColor ?? Colors.transparent),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    title: 'Code',
                    fontWeight: FontWeight.normal,
                    fontSize: 10,
                    textColor: Colors.grey[700],
                    fontStyle: FontStyle.normal,
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          Assets.imgFlag,
                          width: 25,
                          height: 25,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const CustomText(
                        title: '+63',
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        textColor: Colors.black,
                        fontStyle: FontStyle.normal,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextField.mobile(
                controller: controller,
                hintText: 'Mobile Number',
                borderRadius: 25,
                readOnly: readOnly,
                maxLines: 1,
                maxLength: 10,
                fillColor: backgroundColor,
                onChanged: (phone) {
                  if (phone.length == 10) {
                    FocusScope.of(context).unfocus();
                  }
                },
                suffixIcon: IconTextFieldWidget(
                  iconData: Icons.clear,
                  margin: EdgeInsets.only(right: 10),
                  onTap: onTapClear,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
