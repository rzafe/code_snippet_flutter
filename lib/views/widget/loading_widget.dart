
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/common/_common.dart';
import '../../utilities/_utils.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.image = Assets.transparentLogo,
    this.bgColor,
  });

  final String image;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, bool>(
      builder: (BuildContext context, bool isEnable) {
        return Visibility(
          visible: isEnable ? true : false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            body: Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              height: double.infinity,
              color: bgColor ?? Colors.white.withValues(alpha: .9),
              child: SafeArea(
                child: Column(
                  children: [
                    Spacer(),
                    Image.asset(
                      image,
                      fit: BoxFit.fill,
                      width: 200,
                      height: 200,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
