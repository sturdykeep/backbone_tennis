import 'dart:async';

import 'package:backbone/position_node.dart';
import 'package:backbone/prelude/transform.dart';
import 'package:backbone_tennis/game_consts.dart';
import 'package:backbone_tennis/traits/score_trait.dart';
import 'package:backbone_tennis/traits/text_trait.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

/// A node to show the current score of a player
class ScoreNode extends PositionNode {
  final PlayerSide playerSide;
  TextTrait get text => get<TextTrait>();

  ScoreNode({
    required this.playerSide,
  }) : super(
          transformTrait: TransformTrait()
            ..position = playerSide == PlayerSide.left
                ? playerScoreLeft
                : playerScoreRight,
        ) {
    addTrait(
      ScoreTrait(
        side: playerSide,
      ),
    );
    final textTrait = TextTrait();
    textTrait.style = const TextStyle(
      fontSize: 35,
    );
    addTrait(textTrait);
  }

  @override
  FutureOr<void> onLoad() {
    add(TextComponent());
    return super.onLoad();
  }
}
