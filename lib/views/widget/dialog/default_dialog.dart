
import 'package:flutter/material.dart';

import '../../../utilities/_utils.dart';
import '../_widget.dart';

class DefaultDialog extends StatelessWidget {
  const DefaultDialog({
    super.key,
    this.title,
    required this.message,
    this.textButton,
    this.cancelTextButton,
    this.dialogWidth,
    this.visibleCancelButton = false,
    this.onTap,
    this.onTapCancel,
    this.onTapExit,
  });

  final String? title;
  final String message;
  final String? textButton;
  final String? cancelTextButton;
  final double? dialogWidth;
  final bool visibleCancelButton;
  final Function()? onTap;
  final Function()? onTapCancel;
  final Function()? onTapExit;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) async {
        if (didPop) return;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            GestureDetector(
              onTap: onTapExit ?? () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withValues(alpha: 0.1),
              ),
            ),
            Center(
              child: Wrap(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        width: dialogWidth ?? (isTablet ? width * .5 : width * .8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            CustomText(
                              text: title ?? '',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              visible: title != null ? true : false,
                            ),
                            CustomText(
                              text: message,
                              color: Colors.black,
                              fontSize: 13,
                              textAlign: TextAlign.center,
                              margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                            ),
                            const SizedBox(height: 20,),
                            CustomButton(
                              title: textButton ?? 'OK',
                              buttonWidth: double.infinity,
                              onTap: onTap ?? () {
                                Navigator.pop(context);
                              },
                            ),
                            CustomButton(
                              title: cancelTextButton ?? 'CANCEL',
                              buttonWidth: double.infinity,
                              buttonColor: Colors.white,
                              textColor: primaryColor,
                              borderColor: primaryColor,
                              visible: visibleCancelButton,
                              onTap: onTapCancel ?? () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
