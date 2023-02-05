import 'package:flutter/widgets.dart';

/// Shorthand to take an animation and run it either once or in cycle
void fireAnimation(
  AnimationController controller, {
  bool forward = true,
  int cycle = 1,
}) {
  if (cycle < 1) return;

  if (cycle > 1) {
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        cycle -= 1;
        forward = !forward;
        if (cycle > 0) {
          if (forward) {
            controller.forward();
          } else {
            controller.reverse();
          }
        }
      }
    });
  }

  if (forward) {
    controller.forward();
  } else {
    controller.reverse();
  }
}
