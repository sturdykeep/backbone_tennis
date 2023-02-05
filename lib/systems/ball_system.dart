import 'dart:math';

import 'package:backbone/builders.dart';
import 'package:backbone/filter.dart';
import 'package:backbone/prelude/time.dart';
import 'package:backbone/prelude/transform.dart';
import 'package:backbone/realm.dart';
import 'package:backbone_tennis/game_consts.dart';
import 'package:backbone_tennis/messages/player_scored_message.dart';
import 'package:backbone_tennis/nodes/player_node.dart';
import 'package:backbone_tennis/traits/ball_trait.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

/// Register the BallTrait & ballSystem
void ballPlugin(RealmBuilder builder) {
  builder.withTrait(BallTrait);
  builder.withSystem(ballSystem);
}

/// Update the ball position if launched or reset to start if not
void ballSystem(Realm realm) {
  final balls = realm.query(Has([BallTrait]));
  final time = realm.getResource<Time>();
  for (final ball in balls) {
    final trait = ball.get<BallTrait>();
    final transform = ball.get<TransformTrait>();
    if (trait.launched == false) {
      transform.position = dashStartPosition;
      transform.rotation = 0;
      continue;
    }
    // Handle any pendiing collision
    for (final collisionInfo in trait.collisions) {
      final firstCollisionPoint = collisionInfo.intersectionPoints.first;
      FlameAudio.play("beep.wav");
      // If we hit the left/right a player scores, if we hit top or bottom we reflect off
      if (collisionInfo.other is ScreenHitbox) {
        if (firstCollisionPoint.x == 0) {
          realm.pushMessage(PlayerScoredMessage(playerSide: PlayerSide.right));
          break;
        } else if (firstCollisionPoint.x == 640) {
          realm.pushMessage(PlayerScoredMessage(playerSide: PlayerSide.left));
          break;
        }
        // At this point we know that the ball touched the top/bottom of the screen
        trait.direction.multiply(Vector2(1, -1));
      } else {
        // Ball touched the player
        final playerRect = (collisionInfo.other as PlayerNode).toAbsoluteRect();
        final isLeftHit = firstCollisionPoint.x == playerRect.left;
        final isRightHit = firstCollisionPoint.x == playerRect.right;
        final isTopHit = firstCollisionPoint.y == playerRect.bottom;
        final isBottomHit = firstCollisionPoint.y == playerRect.top;

        final isLeftOrRight = isLeftHit || isRightHit;
        final isTopOrBottom = isTopHit || isBottomHit;

        if (isLeftOrRight) {
          trait.direction.multiply(Vector2(-1, 1));
        }
        if (isTopOrBottom) {
          trait.direction.multiply(Vector2(1, -1));
        }
      }
      // Increase ball speed for each bounce
      trait.speed += 20;
    }
    // Remove collisions
    trait.collisions.clear();
    // Change ball posision
    transform.position += (trait.direction * trait.speed) * time.delta;
    // Update heading
    final heading = atan2(trait.direction.y, trait.direction.x);
    transform.rotation = heading;
  }
}
