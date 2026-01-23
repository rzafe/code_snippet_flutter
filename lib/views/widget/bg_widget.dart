
import 'package:flutter/material.dart';

class BGWidget extends StatelessWidget {
  const BGWidget({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          image,
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
      ],
    );
  }
}

