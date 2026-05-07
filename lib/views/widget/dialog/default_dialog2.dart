import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../utilities/_utils.dart';
import '../_widget.dart';

class DefaultDialog2 extends StatelessWidget {
  const DefaultDialog2({
    super.key,
    this.title,
    required this.message,
    this.okTextButton,
    this.cancelTextButton,
    this.onTapCancel,
    this.onTapOK,
    this.onTapExit,
  });

  final String? title;
  final String message;
  final String? okTextButton;
  final String? cancelTextButton;
  final VoidCallback? onTapCancel;
  final VoidCallback? onTapOK;
  final VoidCallback? onTapExit;

  @override
  Widget build(BuildContext context) {
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
                        width: isTablet
                            ? width(context) * .5
                            : width(context) * .8,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Gap(10),
                            if (title != null &&
                                title!.isNotEmpty) ...[
                              CustomText(
                                text: title ?? '',
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                                margin: const EdgeInsets.only(top: 0),
                              ),
                              Gap(10),
                            ],
                            CustomText(
                              text: message,
                              color: Colors.black,
                              fontSize: 14,
                              textAlign: TextAlign.center,
                              margin: const EdgeInsets.only(bottom: 10),
                            ),
                            const CustomDivider(
                              color: primaryColor,
                              margin: EdgeInsets.symmetric(vertical: 5),
                            ),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: CustomText(
                                        text: cancelTextButton ?? 'CANCEL',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        margin: const EdgeInsets.symmetric(vertical: 5),
                                        onTap: onTapCancel ?? () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ),
                                  const CustomVerticalDivider(
                                    color: primaryColor,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: CustomText(
                                        text: okTextButton ?? 'OK',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                        margin: const EdgeInsets.symmetric(vertical: 5),
                                        onTap: onTapOK,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
