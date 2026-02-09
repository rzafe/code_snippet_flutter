
import 'package:flutter/material.dart';

class CustomBrokenLine extends StatelessWidget {
  final Axis axis;
  final double dashLength;
  final double dashGap;
  final double thickness;
  final Color color;
  final double length; // if inside flexible area, ignore this
  final bool visible;
  final EdgeInsets margin;

  const CustomBrokenLine({
    super.key,
    this.axis = Axis.horizontal,
    this.dashLength = 6,
    this.dashGap = 4,
    this.thickness = 2,
    this.color = Colors.black,
    this.length = double.infinity,
    this.visible = true,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: CustomPaint(
          size: axis == Axis.horizontal
              ? Size(length, thickness)
              : Size(thickness, length),
          painter: _BrokenLinePainter(
            axis: axis,
            dashLength: dashLength,
            dashGap: dashGap,
            thickness: thickness,
            color: color,
          ),
        ),
      ),
    );
  }
}

/// ----------------------------------------------------------------------------
class _BrokenLinePainter extends CustomPainter {
  final Axis axis;
  final double dashLength;
  final double dashGap;
  final double thickness;
  final Color color;

  _BrokenLinePainter({
    required this.axis,
    required this.dashLength,
    required this.dashGap,
    required this.thickness,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness;

    double start = 0;
    final max = axis == Axis.horizontal ? size.width : size.height;

    while (start < max) {
      final end = ((start + dashLength).clamp(0.0, max)).toDouble();

      if (axis == Axis.horizontal) {
        canvas.drawLine(
          Offset(start, thickness / 2),
          Offset(end, thickness / 2),
          paint,
        );
      } else {
        canvas.drawLine(
          Offset(thickness / 2, start),
          Offset(thickness / 2, end),
          paint,
        );
      }

      start += dashLength + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

