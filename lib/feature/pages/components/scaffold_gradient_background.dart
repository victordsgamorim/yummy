import 'package:flutter/material.dart';
import 'package:yummy_app/core/utils/extensions/context_extension.dart';

class ScaffoldGradientBackground extends StatelessWidget {
  final Widget body;

  const ScaffoldGradientBackground({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.colorScheme.inversePrimary,
                  context.colorScheme.surface,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          body
        ],
      ),
    );
  }
}
