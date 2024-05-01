import 'package:flutter/material.dart';
import 'package:yummy_app/core/utils/constants/values.dart';
import 'package:yummy_app/core/utils/extensions/context_extension.dart';

class Incrementer extends StatefulWidget {
  final int? initValue;
  final double radius;
  final double fontSize;
  final Function(int value)? onIncrement;

  const Incrementer({
    super.key,
    this.initValue,
    this.radius = 20,
    this.fontSize = 24,
    this.onIncrement,
  });

  @override
  State<Incrementer> createState() => _IncrementerState();
}

class _IncrementerState extends State<Incrementer> {
  int quantity = 0;

  @override
  void initState() {
    if (widget.initValue != null) quantity = widget.initValue!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionButton(
          radius: widget.radius,
          onPressed: () {
            if (quantity > 0) {
              setState(() {
                quantity--;
                _onIncrement();
              });
            }
          },
          icon: Icons.remove,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding),
          child: Text(
            quantity.toString(),
            style: context.theme.textTheme.titleLarge
                ?.copyWith(fontSize: widget.fontSize),
          ),
        ),
        _ActionButton(
          radius: widget.radius,
          onPressed: () {
            setState(() {
              quantity++;
              _onIncrement();
            });
          },
          icon: Icons.add,
        )
      ],
    );
  }

  void _onIncrement() {
    if (widget.onIncrement != null) widget.onIncrement!(quantity);
  }
}

class _ActionButton extends StatelessWidget {
  final double radius;
  final VoidCallback onPressed;
  final IconData icon;

  const _ActionButton({
    required this.onPressed,
    required this.icon,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: Center(
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
        ),
      ),
    );
  }
}
