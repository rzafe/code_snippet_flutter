
import 'package:flutter/material.dart';

import '../../utilities/_utils.dart';
import '_widget.dart';

class FormStepIndicator extends StatelessWidget {
  const FormStepIndicator({
    super.key,
    required this.steps,
    required this.currentIndex,
    this.visible = true,
    this.margin = EdgeInsets.zero,
  });

  final int steps;
  final int currentIndex;
  final bool visible;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 5,
          children: List.generate(
            steps,
                (index) => Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: index == currentIndex ? tertiaryColor : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ----------------------------------------------------------------------------
class FormStepIndicator2 extends StatelessWidget {
  const FormStepIndicator2({
    super.key,
    required this.steps,       // total number of steps
    required this.currentStep, // active step (1-based)
    this.visible = true,
    this.margin = EdgeInsets.zero,
  });

  final int steps;
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
          children: List.generate(steps, (index) {
            final step = index + 1;
            final bool isActive = currentStep == step;

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
          }),
        ),
      ),
    );
  }
}

/// ----------------------------------------------------------------------------
class FormStepIndicator3 extends StatelessWidget {
  const FormStepIndicator3({
    super.key,
    required this.steps,       // total number of steps
    required this.currentStep, // active step (1-based)
    this.visible = true,
    this.margin = EdgeInsets.zero,
  });

  final int steps;
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
          children: List.generate(
            steps * 2 - 1,
                (index) {
              // gap between bars
              if (index.isOdd) {
                return const SizedBox(width: 8);
              }

              final stepIndex = index ~/ 2;
              final step = stepIndex + 1;
              final bool isActive = currentStep == step;

              return Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 4,
                  decoration: BoxDecoration(
                    color: isActive
                        ? primaryColor
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    // return Visibility(
    //   visible: visible,
    //   child: Padding(
    //     padding: margin,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: List.generate(steps, (index) {
    //         final step = index + 1;
    //         final bool isActive = currentStep == step;
    //
    //         return Expanded(
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 0),
    //             child: AnimatedContainer(
    //               duration: const Duration(milliseconds: 250),
    //               height: 4,
    //               decoration: BoxDecoration(
    //                 color: isActive
    //                     ? primaryColor
    //                     : Colors.grey.shade300,
    //                 borderRadius: BorderRadius.circular(4),
    //               ),
    //             ),
    //           ),
    //         );
    //       }),
    //     ),
    //   ),
    // );
  }
}
