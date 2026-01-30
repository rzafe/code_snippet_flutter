
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utilities/_utils.dart';

class LoadImageWidget extends StatelessWidget {
  const LoadImageWidget({
    super.key,
    required this.imageUrl,
    this.imageFit,
    this.width,
    this.height,
    this.holderWidth,
    this.holderHeight,
    this.radius = 10,
    this.bgErrorColor,
    this.iconColor,
    this.visible = true,
    this.margin = EdgeInsets.zero,
    this.onTap,
  });

  final String imageUrl;
  final BoxFit? imageFit;
  final double? width;
  final double? height;
  final double? holderWidth;
  final double? holderHeight;
  final double radius;
  final Color? bgErrorColor;
  final Color? iconColor;
  final bool visible;
  final EdgeInsets margin;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Center(
        child: Padding(
          padding: margin,
          child: GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: width,
              height: height,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                child: CachedNetworkImage(
                  fit: imageFit ?? BoxFit.fill,
                  imageUrl: imageUrl,
                  placeholder: (context, url) {
                    return Container(
                      width: holderWidth,
                      height: holderHeight,
                      decoration: BoxDecoration(
                        color: primaryColor,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      width: holderWidth,
                      height: holderHeight,
                      decoration: BoxDecoration(
                        color: bgErrorColor ?? primaryColor,
                      ),
                      child: Icon(
                        Icons.info_outline,
                        color: iconColor ?? Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
