import 'package:backbone/trait.dart';
import 'package:flame/components.dart';

/// Store the direction, speed and state of any ball
class BallTrait extends ATrait {
  late Vector2 direction;
  double speed = 5;
  bool launched = false;
  List<CollisionInformation> collisions = [];
  BallTrait(this.direction);

  void reset() {
    direction = Vector2.zero();
    speed = 0;
    launched = false;
    collisions.clear();
  }
}

/// Information stored in case of a collision with another component
class CollisionInformation {
  final PositionComponent other;
  final Set<Vector2> intersectionPoints;

  CollisionInformation(this.other, this.intersectionPoints);
}
