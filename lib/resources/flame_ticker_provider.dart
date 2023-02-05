import 'package:flutter/scheduler.dart';

/// Ticker provider for tween animations
class FlameTickerProvider implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
