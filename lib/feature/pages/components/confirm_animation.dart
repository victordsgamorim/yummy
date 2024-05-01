import 'package:flutter/material.dart';
import 'package:yummy_app/core/utils/extensions/context_extension.dart';

class ConfirmAnimation extends StatefulWidget {
  final Function(bool complete)? whenCompleted;

  const ConfirmAnimation({super.key, this.whenCompleted});

  @override
  State<ConfirmAnimation> createState() => _ConfirmAnimationState();
}

class _ConfirmAnimationState extends State<ConfirmAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleTransition;
  late final Animation<double> _opacityTransition;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _scaleTransition = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.bounceOut),
      ),
    );

    _opacityTransition = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1, curve: Curves.linear),
      ),
    );
    _controller.forward();

    _controller.addStatusListener(_statusListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Center(
        child: ScaleTransition(
          scale: _scaleTransition,
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: context.colorScheme.onPrimaryContainer,
              borderRadius: BorderRadius.circular(200),
            ),
            child: FadeTransition(
              opacity: _opacityTransition,
              child: const FittedBox(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.done_rounded,
                  color: Colors.white,
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }

  void _statusListener(status) {
    if (widget.whenCompleted != null) {
      widget.whenCompleted!(status == AnimationStatus.completed);
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_statusListener);
    _controller.dispose();
    super.dispose();
  }
}
