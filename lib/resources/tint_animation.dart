import 'package:backbone_tennis/resources/default_animation.dart';
import 'package:backbone_tennis/resources/fire_forget_animation.dart';
import 'package:backbone_tennis/resources/flame_ticker_provider.dart';
import 'package:backbone_tennis/traits/text_trait.dart';
import 'package:flutter/material.dart';

/// Let any text blink in a given color. Text will animate from current color to blinkColor and back to initial color
void blink(TextTrait trait, Color blinkColor) {
  final initialColor = trait.style.color ?? Colors.white;
  fireAnimation(
    simpleAnimation(
      tickerProvider: trait.node!.realm!.getResource<FlameTickerProvider>(),
      callback: (value) {
        final currentColor = Color.lerp(initialColor, blinkColor, value);
        trait.style = trait.style.copyWith(
          color: currentColor,
        );
      },
    ),
    cycle: 2,
  );
}
