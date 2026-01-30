
import 'package:flutter/material.dart';

import '../../utilities/_utils.dart';
import '_widget.dart';

class FormStepIndicator extends StatelessWidget {
  const FormStepIndicator({
    super.key,
    required this.steps,
    required this.currentStep,
    this.visible = true,
    this.margin = EdgeInsets.zero,
  });

  final List<int> steps;
  final int currentStep;
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
          spacing: 12,
          children: steps.map((step) {
            bool isActive = currentStep == step;
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? primaryColor.withValues(alpha: 0.5)
                    : Colors.grey.shade300,
              ),
              child: CustomText(
                title: '$step',
                textColor: isActive ? primaryColor : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
