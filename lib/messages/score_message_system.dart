import 'package:backbone/filter.dart';
import 'package:backbone/message.dart';
import 'package:backbone/realm.dart';
import 'package:backbone_tennis/messages/player_scored_message.dart';
import 'package:backbone_tennis/messages/reset_player_score_message.dart';
import 'package:backbone_tennis/nodes/player_won.node.dart';
import 'package:backbone_tennis/resources/player_score.dart';
import 'package:backbone_tennis/traits/ball_trait.dart';
import 'package:backbone_tennis/traits/text_trait.dart';

bool scoreMessageSystem(Realm realm, AMessage message) {
  // If a player scored update the score and reset the ball(s)
  if (message is PlayerScoredMessage) {
    final score = realm.getResource<PlayerScore>();
    score.playerScored(message.playerSide);
    final balls = realm.query(Has([BallTrait]));
    for (final ball in balls) {
      ball.get<BallTrait>().reset();
    }
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
