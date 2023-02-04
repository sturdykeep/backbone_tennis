import 'package:backbone/trait.dart';
import 'package:flame/components.dart';

/// Store the direction, speed and state of any ball
class BallTrait extends ATrait {
  late Vector2 direction;
  double speed = 5;
  bool launched = false;
  BallTrait(this.direction);

  void reset() {
    direction = Vector2.zero();
    speed = 0;
    launched = false;
  }
}
