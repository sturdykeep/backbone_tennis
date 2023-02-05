import 'package:flutter/widgets.dart';

typedef AnimationCallback = void Function(double value);

/// Shorthand function to setup a tween animation for any type
AnimationController simpleAnimation({
  required TickerProvider tickerProvider,
  required AnimationCallback callback,
  VoidCallback? animationDone,
  double begin = 0,
  double end = 1,
  Duration duration = const Duration(milliseconds: 400),
  Curve? curve,
}) {
  final controller = AnimationController(
    vsync: tickerProvider,
    duration: duration,
  );

  var tween = Tween<double>(
    begin: begin,
    end: end,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: curve ?? Curves.easeOut,
    ),
  );

  tween.addListener(() {
    callback.call(tween.value);
  });
  tween.addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      animationDone?.call();
    }
  });
  return controller;
}
