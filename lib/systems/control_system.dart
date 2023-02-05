import 'package:backbone/builders.dart';
import 'package:backbone/filter.dart';
import 'package:backbone/prelude/input/mod.dart';
import 'package:backbone/prelude/transform.dart';
import 'package:backbone/realm.dart';
import 'package:backbone_tennis/game_consts.dart';
import 'package:backbone_tennis/messages/reset_player_score_message.dart';
import 'package:backbone_tennis/resources/player_score.dart';
import 'package:backbone_tennis/traits/ball_trait.dart';
import 'package:backbone_tennis/traits/player_trait.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';

/// Add the traits for LeftPlayerTrait, RightPlayerTrait and the controlSystem
void playerControlPlugin(RealmBuilder builder) {
  builder.withTrait(LeftPlayerTrait);
  builder.withTrait(RightPlayerTrait);
  builder.withSystem(controlSystem);
}

/// Handles all game inputs
void controlSystem(Realm realm) {
  final input = realm.getResource<Input>();
  final balls = realm.query(Has([BallTrait]));
  if (input.justPressed(startRoundButton)) {
    for (final ball in balls) {
      final trait = ball.get<BallTrait>();
      if (trait.launched == false) {
        if (realm.getResource<PlayerScore>().anySideWonYet) {
          realm.pushMessage(ResetPlayerScoreMessage());
        }
        // Vector2.random only produces results in range 0.1
        // this will allow the ball also to go left/up
        final shootLeft = rnd.nextBool() ? -1.0 : 1.0;
        final shootUp = rnd.nextBool() ? -1.0 : 1.0;
        trait.direction = Vector2.random().normalized();
        trait.direction.multiply(Vector2(shootLeft, shootUp));
        trait.speed = initialBallSpeed;
        trait.launched = true;
      }
    }
  }

  if (balls.any((element) => element.get<BallTrait>().launched == false)) {
    return;
  }

  _handlePlayerKeys(
    input,
    [
      leftPlayerControlUp,
      leftPlayerControlDow,
    ],
    () => realm.query(Has([LeftPlayerTrait])).first.get<TransformTrait>(),
  );
  _handlePlayerKeys(
    input,
    [
      rightPlayerControlUp,
      rightlayerControlDown,
    ],
    () => realm.query(Has([RightPlayerTrait])).first.get<TransformTrait>(),
  );
}

void _handlePlayerKeys(
  Input input,
  List<LogicalKeyboardKey> keys,
  TransformTrait Function() getPlayerIfNeeded, {
  Vector2? speed,
}) {
  speed ??= Vector2(0, 10);
  if (input.pressedAny(keys) || input.justPressedAny(keys)) {
    final transformTraitOfPlayer = getPlayerIfNeeded();
    final firstKey = keys.first;
    if (input.pressed(firstKey) || input.justPressed(firstKey)) {
      if (transformTraitOfPlayer.position.y >= 10) {
        transformTraitOfPlayer.position += speed.scaled(-1);
      }
    } else {
      if (transformTraitOfPlayer.position.y + playerSize.y < 470) {
        transformTraitOfPlayer.position += speed;
      }
    }
  }
}
