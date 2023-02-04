import 'dart:async';

import 'package:backbone/position_node.dart';
import 'package:backbone/prelude/transform.dart';
import 'package:backbone_tennis/traits/text_trait.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

/// The text shown below the scores to announce a winner
class PlayerWonNode extends PositionNode {
  PlayerWonNode({required String text})
      : super(
          transformTrait: TransformTrait()
            ..position = Vector2(200, 80)
            ..size = Vector2(260, 60),
        ) {
    final textTrait = TextTrait();
    textTrait.text = text;
    textTrait.anchor = Anchor.center;
    textTrait.style = const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
    );
    addTrait(textTrait);
  }

  @override
  FutureOr<void> onLoad() {
    add(TextComponent());
    return super.onLoad();
  }
}
