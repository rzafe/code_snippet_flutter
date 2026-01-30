
import 'package:flutter/material.dart';

import '../../utilities/_utils.dart';

class LoadingCircularProgress extends StatelessWidget {
  const LoadingCircularProgress({
    super.key,
    this.widthSize,
    this.heightSize,
    this.visible = true,
    this.margin = EdgeInsets.zero,
  });

  final double? widthSize;
  final double? heightSize;
  final bool visible;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: SizedBox(
          width: widthSize,
          height: heightSize ?? height(context) * .15,
          child: Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
