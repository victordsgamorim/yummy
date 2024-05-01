import 'package:flutter/material.dart';
import 'package:yummy_app/core/utils/extensions/context_extension.dart';
import 'package:yummy_app/gen/fonts.gen.dart';

class Logo extends StatelessWidget {
  final double fontSize;
  const Logo({super.key, this.fontSize = 40});

  @override
  Widget build(BuildContext context) {
    return Text(
      '[Yummy]',
      style: context.theme.textTheme.titleLarge?.copyWith(
        fontFamily: FontFamily.foodpacker,
        letterSpacing: 2,
        fontSize: fontSize
      ),
    );
  }
}
