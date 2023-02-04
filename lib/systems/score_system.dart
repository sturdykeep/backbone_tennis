import 'package:backbone/builders.dart';
import 'package:backbone/filter.dart';
import 'package:backbone/prelude/transform.dart';
import 'package:backbone/realm.dart';
import 'package:backbone_tennis/game_consts.dart';
import 'package:backbone_tennis/nodes/player_node.dart';
import 'package:backbone_tennis/nodes/player_won.node.dart';
import 'package:backbone_tennis/resources/player_score.dart';
import 'package:backbone_tennis/traits/score_trait.dart';
import 'package:backbone_tennis/traits/text_trait.dart';
import 'package:flame/components.dart';

/// Add the ScoreTrait and scoreSystem
void scorePlugin(RealmBuilder builder) {
  builder.withTrait(ScoreTrait);
  builder.withSystem(scoreSystem);
}

/// Handle any changes to the score,
void scoreSystem(Realm realm) {
  final query = realm.query(Has([ScoreTrait, TextTrait]));
  final playerScores = realm.getResource<PlayerScore>();
  for (final node in query) {
    final playerSide = node.get<ScoreTrait>().side;

    final currentScoreForPlayer = playerSide == PlayerSide.left
        ? playerScores.scoreLeftPlayer
        : playerScores.scoreRightPlayer;
    node.get<TextTrait>().text = currentScoreForPlayer.toString();
    if (currentScoreForPlayer == winningPoints) {
      final winningText =
          "${playerSide.name.toString().capitalize()} Player Won!";
      realm.nodesByType[PlayerWonNode]!.first.get<TextTrait>().text =
          winningText;

      for (final player in realm.nodesByType[PlayerNode]!) {
        late final Vector2 start;
        if ((player as PlayerNode).playerSide == PlayerSide.left) {
          start = startPlayerLeft;
        } else {
          start = startPlayerRight;
        }
        player.get<TransformTrait>().position = start;
      }
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
