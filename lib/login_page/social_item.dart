import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SocialItem extends StatelessWidget {
  String image;
  final Function()? onTap;

  SocialItem({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        child: InkWell(
          splashColor: Colors.green[700],
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(
              15,
            ),
            child: Image.asset(
              image,
              height: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}
