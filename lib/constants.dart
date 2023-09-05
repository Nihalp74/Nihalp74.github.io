import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConstantLottieAnimation extends StatelessWidget {
  final String animationPath;
  final double? width;
  final double? height;

  const ConstantLottieAnimation({
    super.key,
    required this.animationPath,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      animationPath,
      width: width,
      height: height,
    );
  }
}
