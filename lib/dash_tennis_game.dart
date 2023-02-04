import 'dart:async';

import 'package:backbone/builders.dart';
import 'package:backbone/prelude/mod.dart';
import 'package:backbone/realm_mixin.dart';
import 'package:backbone_tennis/game_consts.dart';
import 'package:backbone_tennis/messages/score_message_system.dart';
import 'package:backbone_tennis/nodes/dash_ball_node.dart';
import 'package:backbone_tennis/nodes/player_node.dart';
import 'package:backbone_tennis/nodes/player_won.node.dart';
import 'package:backbone_tennis/nodes/score_node.dart';
import 'package:backbone_tennis/resources/player_score.dart';
import 'package:backbone_tennis/systems/ball_system.dart';
import 'package:backbone_tennis/systems/control_system.dart';
import 'package:backbone_tennis/systems/score_system.dart';
import 'package:backbone_tennis/systems/sprite_system.dart';
import 'package:backbone_tennis/systems/text_system.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';

/// Main game class
class DashTennisGame extends FlameGame
    with
        HasTappableComponents,
        HasDraggableComponents,
        HasCollisionDetection,
        KeyboardEvents,
        HasRealm {
  DashTennisGame()
      : super(
          camera: Camera()
            ..viewport = FixedResolutionViewport(
              Vector2(
                640,
                480,
              ),
            ),
        );

  @override
  FutureOr<void> onLoad() {
    realm = RealmBuilder()
        .withPlugin(defaultPlugin)
        .withPlugin(spritePlugin)
        .withPlugin(textPlugin)
        .withPlugin(scorePlugin)
        .withPlugin(playerControlPlugin)
        .withPlugin(ballPlugin)
        .withResource(PlayerScore, PlayerScore())
        .withMessageSystem(scoreMessageSystem)
        .build();

    add(realm);
    // Init the player nodes and dash
    realm.addAll([
      PlayerNode(
        playerSide: PlayerSide.left,
      ),
      PlayerNode(
        playerSide: PlayerSide.right,
      ),
      DashBallNode(),
      ScoreNode(
        playerSide: PlayerSide.left,
      ),
      ScoreNode(
        playerSide: PlayerSide.right,
      ),
      PlayerWonNode(text: ""),
    ]);
    realm.add(ScreenHitbox());

    realmReady = true;
    return super.onLoad();
  }
}
