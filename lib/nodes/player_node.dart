import 'dart:async';

import 'package:backbone/position_node.dart';
import 'package:backbone/prelude/transform.dart';
import 'package:backbone_tennis/game_consts.dart';
import 'package:backbone_tennis/traits/player_trait.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

/// This is our player node, either left/right
class PlayerNode extends PositionNode {
  final PlayerSide playerSide;

  PlayerNode({
    required this.playerSide,
  }) : super(
          transformTrait: TransformTrait()
            ..size = playerSize
            ..position = playerSide == PlayerSide.left
                ? startPlayerLeft
                : startPlayerRight,
        ) {
    // Tag the player for either side
    addTrait(
      playerSide == PlayerSide.left ? LeftPlayerTrait() : RightPlayerTrait(),
    );
  }

  @override
  FutureOr<void> onLoad() {
    add(
      RectangleComponent(
        size: playerSize,
        paint: playerPaint,
      ),
    );
    add(RectangleHitbox());
    return super.onLoad();
  }
}
