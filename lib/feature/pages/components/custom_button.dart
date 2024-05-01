import 'package:flutter/material.dart';
import 'package:yummy_app/core/utils/extensions/context_extension.dart';

class CustomElevatedButton extends StatelessWidget {
  final bool enable;
  final GestureTapCallback onTap;
  final String label;

  const CustomElevatedButton({
    super.key,
    required this.label,
    required this.onTap,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enable ? 1 : .3,
      child: AbsorbPointer(
        absorbing: !enable,
        child: Card(
          elevation: 0,
          color: context.colorScheme.onPrimaryContainer,
          child: ListTile(
            onTap: onTap,
            title: Center(
              child: Text(
                label,
                style: context.theme.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.primaryContainer,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
