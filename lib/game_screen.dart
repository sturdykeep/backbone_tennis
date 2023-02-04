import 'package:backbone/widget.dart';
import 'package:backbone_tennis/dash_tennis_game.dart';
import 'package:flutter/material.dart';

/// Widget to render the tennis dash game
class GameScreen extends StatelessWidget {
  final DashTennisGame game = DashTennisGame();

  GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackboneGameWidget<DashTennisGame>(
      game: game,
      loadingBuilder: (buildContext) {
        // Show a spinner while loading the game
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
