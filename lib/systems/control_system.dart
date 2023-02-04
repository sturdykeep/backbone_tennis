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
  final ball = realm.query(Has([BallTrait])).first;
  final trait = ball.get<BallTrait>();
  if (input.justPressed(startRoundButton)) {
    if (trait.launched == false) {
      if (realm.getResource<PlayerScore>().anySideWonYet) {
        realm.pushMessage(ResetPlayerScoreMessage());
      }

      trait.direction = Vector2.random().normalized();
      trait.speed = initialBallSpeed;
      trait.launched = true;
    }
  }
  if (trait.launched == false) return;
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
