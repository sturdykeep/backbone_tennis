import 'dart:ui';

import 'package:backbone/filter.dart';
import 'package:backbone/message.dart';
import 'package:backbone/prelude/transform.dart';
import 'package:backbone/realm.dart';
import 'package:backbone_tennis/game_consts.dart';
import 'package:backbone_tennis/messages/player_scored_message.dart';
import 'package:backbone_tennis/messages/reset_player_score_message.dart';
import 'package:backbone_tennis/nodes/player_node.dart';
import 'package:backbone_tennis/nodes/player_won.node.dart';
import 'package:backbone_tennis/nodes/score_node.dart';
import 'package:backbone_tennis/resources/player_score.dart';
import 'package:backbone_tennis/resources/tint_animation.dart';
import 'package:backbone_tennis/traits/ball_trait.dart';
import 'package:backbone_tennis/traits/player_trait.dart';
import 'package:backbone_tennis/traits/text_trait.dart';
import 'package:flame/game.dart';

bool scoreMessageSystem(Realm realm, AMessage message) {
  // If a player scored update the score and reset the ball(s)
  if (message is PlayerScoredMessage) {
    final score = realm.getResource<PlayerScore>();
    score.playerScored(message.playerSide);

    final balls = realm.query(Has([BallTrait]));
    for (final ball in balls) {
      ball.get<BallTrait>().reset();
    }

    final players = realm.query(
      Or(
        [
          Has(
            [
              LeftPlayerTrait,
            ],
          ),
          Has(
            [
              RightPlayerTrait,
            ],
          )
        ],
      ),
    );
    for (var player in players) {
      late final Vector2 start;
      if ((player as PlayerNode).playerSide == PlayerSide.left) {
        start = startPlayerLeft;
      } else {
        start = startPlayerRight;
      }
      player.get<TransformTrait>().position = start;
    }
    // Get the score of the element that got a point
    final textOfScoringPlayer = realm
        .query(Has([TextTrait]))
        .whereType<ScoreNode>()
        .where((element) => element.playerSide == message.playerSide)
        .first
        .get<TextTrait>();
    // Let the score blink bluw using Flutters Tween animation system
    blink(
      textOfScoringPlayer,
      const Color.fromARGB(255, 94, 172, 236),
    );

    return true;
  } else if (message is ResetPlayerScoreMessage) {
    // Reset all scores to zero
    realm.getResource<PlayerScore>().resetScores();
    // Reset the "Player XX has won" text to nothing
    realm
        .query(Has([TextTrait]))
        .whereType<PlayerWonNode>()
        .first
        .get<TextTrait>()
        .text = "";

    return true;
  }
  // We dont handle this message
  return false;
}
