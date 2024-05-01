import 'package:flutter/material.dart';
import 'package:yummy_app/core/utils/extensions/context_extension.dart';

class CustomBadge extends StatelessWidget {
  final int? quantity;
  final Widget child;

  const CustomBadge({super.key, required this.child, this.quantity});

  @override
  Widget build(BuildContext context) {
    final isNotNull = quantity != null;
    final hasData = isNotNull && quantity! > 0;
    final isBigger = isNotNull && quantity! > 99;
    return Stack(
      children: [
        child,
        if (hasData)
          Positioned(
            right: 0,
            child: Container(
              height: 20,
              width: isBigger ? 30 : 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: context.colorScheme.error,
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                isBigger ? '99+' : quantity.toString(),
                style: context.theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          )
      ],
    );
  }
}
