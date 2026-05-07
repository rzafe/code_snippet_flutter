import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLottie extends StatelessWidget {
  const CustomLottie({
    super.key,

    /// Source
    this.asset,
    this.network,
    this.file,

    /// Layout
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.center = true,
    this.visible = true,

    /// Animation
    this.animate = true,
    this.repeat = true,
    this.reverse = false,
    this.controller,
    this.frameRate,
    this.delegates,
    this.options,

    /// Builder
    this.onLoaded,

    /// Placeholder / Error
    this.loadingWidget,
    this.errorWidget,

    /// Container
    this.decoration,
    this.clipBehavior = Clip.none,
  }) : assert(
  asset != null || network != null || file != null,
  'Provide asset, network, or file source.',
  );

  /// Sources
  final String? asset;
  final String? network;
  final String? file;

  /// Size
  final double? height;
  final double? width;

  /// Layout
  final BoxFit fit;
  final Alignment alignment;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final bool center;
  final bool visible;

  /// Animation
  final bool animate;
  final bool repeat;
  final bool reverse;
  final AnimationController? controller;
  final FrameRate? frameRate;
  final LottieDelegates? delegates;
  final LottieOptions? options;

  /// Callbacks
  final void Function(LottieComposition)? onLoaded;

  /// States
  final Widget? loadingWidget;
  final Widget? errorWidget;

  /// Container
  final Decoration? decoration;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    Widget child;

    /// Common builder
    Widget buildLottie(Widget widget) {
      return SizedBox(
        height: height,
        width: width,
        child: widget,
      );
    }

    /// Asset
    if (asset != null) {
      child = buildLottie(
        Lottie.asset(
          asset!,
          fit: fit,
          alignment: alignment,
          animate: animate,
          repeat: repeat,
          reverse: reverse,
          controller: controller,
          frameRate: frameRate,
          delegates: delegates,
          options: options,
          onLoaded: onLoaded,
          errorBuilder: (_, __, ___) =>
          errorWidget ?? const SizedBox.shrink(),
        ),
      );
    }

    /// Network
    else if (network != null) {
      child = buildLottie(
        Lottie.network(
          network!,
          fit: fit,
          alignment: alignment,
          animate: animate,
          repeat: repeat,
          reverse: reverse,
          controller: controller,
          frameRate: frameRate,
          delegates: delegates,
          options: options,
          onLoaded: onLoaded,
          errorBuilder: (_, __, ___) =>
          errorWidget ?? const SizedBox.shrink(),
        ),
      );
    }

    /// File
    else {
      child = buildLottie(
        Lottie.file(
          File(file!),
          fit: fit,
          alignment: alignment,
          animate: animate,
          repeat: repeat,
          reverse: reverse,
          controller: controller,
          frameRate: frameRate,
          delegates: delegates,
          options: options,
          onLoaded: onLoaded,
          errorBuilder: (_, __, ___) =>
          errorWidget ?? const SizedBox.shrink(),
        ),
      );
    }

    /// Loading wrapper
    child = Stack(
      alignment: Alignment.center,
      children: [
        child,
        if (loadingWidget != null) loadingWidget!,
      ],
    );

    /// Container wrapper
    child = Container(
      margin: margin,
      padding: padding,
      decoration: decoration,
      clipBehavior: clipBehavior,
      child: child,
    );

    /// Center wrapper
    if (center) {
      child = Center(child: child);
    }

    return child;
  }
}