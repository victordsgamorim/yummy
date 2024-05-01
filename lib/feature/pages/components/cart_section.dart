import 'package:flutter/material.dart';
import 'package:yummy_app/core/utils/constants/values.dart';
import 'package:yummy_app/core/utils/extensions/context_extension.dart';

class CartSection extends StatelessWidget {
  final String title;
  final Widget child;
  final bool hasBorder;

  const CartSection({
    super.key,
    required this.title,
    required this.child,
    this.hasBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: padding / 2),
          child: Text(
            title,
            style: context.theme.textTheme.titleMedium,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: hasBorder
                ? Border.all(color: context.colorScheme.onPrimaryContainer)
                : null,
          ),
          child: child,
        )
      ],
    );
  }
}

class CartSeparatedList extends StatelessWidget {
  final int itemCount;
  final NullableIndexedWidgetBuilder itemBuilder;

  const CartSeparatedList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(color: context.colorScheme.onPrimaryContainer);
      },
    );
  }
}
