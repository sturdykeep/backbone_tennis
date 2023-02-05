import 'dart:async';

import 'package:backbone/position_node.dart';
import 'package:backbone_tennis/game_consts.dart';
import 'package:backbone_tennis/traits/ball_trait.dart';
import 'package:backbone_tennis/traits/sprite_trait.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

/// Dash is our tennis ball
class DashBallNode extends PositionNode with CollisionCallbacks {
  SpriteTrait get sprite => get<SpriteTrait>();

  DashBallNode() {
    // Required to render sprites
    addTrait(SpriteTrait());

    // We flag dash as ball
    addTrait(BallTrait(Vector2.random().normalized()));
  }

  @override
  FutureOr<void> onLoad() async {
    // Load and set the sprite
    final dashSprite = await gameRef.loadSprite('dash.png');
    sprite.sprite = dashSprite;

    // Set sizes for dash
    transformTrait.size = dashSize;
    transformTrait.position = dashStartPosition;
    transformTrait.anchor = Anchor.center;

    // Add sprite component and hitbox
    add(
      SpriteComponent(
        sprite: sprite.sprite,
      ),
    );
    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    // Did somebody say multi ball support?
    if (other is DashBallNode) return;
    // Add the collosion to the trait to be handled by the system
    get<BallTrait>().collisions.add(
          CollisionInformation(
            other,
            intersectionPoints,
          ),
        );
  }
}
