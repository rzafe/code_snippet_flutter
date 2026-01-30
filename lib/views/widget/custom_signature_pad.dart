import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import '../../utilities/_utils.dart';

class DynamicSignaturePad extends StatelessWidget {
  final SignatureController controller;
  final double? signatureHeight;
  final double? signatureBorderRadius;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? iconBorderColor;
  final EdgeInsets signaturePadding;
  final bool visible;
  final EdgeInsets margin;

  const DynamicSignaturePad({
    super.key,
    required this.controller,
    this.signatureHeight,
    this.signatureBorderRadius,
    this.backgroundColor,
    this.iconColor,
    this.iconBorderColor,
    this.signaturePadding = EdgeInsets.zero,
    this.visible = true,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final actions = [
      {
        "icon": Icons.undo,
        "tooltip": "Undo",
        "onPressed": () => controller.undo(),
      },
      {
        "icon": Icons.redo,
        "tooltip": "Redo",
        "onPressed": () => controller.redo(),
      },
      {
        "icon": Icons.clear,
        "tooltip": "Clear",
        "onPressed": () => controller.clear(),
      },
    ];

    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: Column(
          children: [
            Padding(
              padding: signaturePadding,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(signatureBorderRadius ?? 0),
                child: Signature(
                  key: const Key('signature'),
                  controller: controller,
                  height: signatureHeight ?? height(context) * .22,
                  backgroundColor: backgroundColor ?? Colors.grey[300]!,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                spacing: 10,
                children: actions.map((action) {
                  return Flexible(
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: iconBorderColor ?? primaryColor,
                          width: 2,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          action["icon"] as IconData,
                        ),
                        color: iconColor ?? primaryColor,
                        tooltip: action["tooltip"] as String,
                        onPressed: action["onPressed"] as VoidCallback,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
