import 'dart:async';

import 'package:backbone/position_node.dart';
import 'package:backbone_tennis/game_consts.dart';
import 'package:backbone_tennis/messages/player_scored_message.dart';
import 'package:backbone_tennis/nodes/player_node.dart';
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
    final firstCollisionPoint = intersectionPoints.first;
    final ballTrait = get<BallTrait>();
    // If we hit the left/right a player scores, if we hit top or bottom we reflect off
    if (other is ScreenHitbox) {
      if (intersectionPoints.first.x == 0) {
        realm!.pushMessage(PlayerScoredMessage(playerSide: PlayerSide.right));
        return;
      } else if (intersectionPoints.first.x == 640) {
        realm!.pushMessage(PlayerScoredMessage(playerSide: PlayerSide.left));
        return;
      }
      // At this point we know that the ball touched the top/bottom of the screen
      ballTrait.direction.multiply(Vector2(1, -1));
    } else {
      // Ball touched the player
      final playerRect = (other as PlayerNode).toAbsoluteRect();
      final isLeftHit = firstCollisionPoint.x == playerRect.left;
      final isRightHit = firstCollisionPoint.x == playerRect.right;
      final isTopHit = firstCollisionPoint.y == playerRect.bottom;
      final isBottomHit = firstCollisionPoint.y == playerRect.top;

      final isLeftOrRight = isLeftHit || isRightHit;
      final isTopOrBottom = isTopHit || isBottomHit;

      if (isLeftOrRight) {
        ballTrait.direction.multiply(Vector2(-1, 1));
      }
      if (isTopOrBottom) {
        ballTrait.direction.multiply(Vector2(1, -1));
      }
    }
    ballTrait.speed += 20;
  }
}
