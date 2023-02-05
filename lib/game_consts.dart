import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Starting position of the left player
final startPlayerLeft = Vector2(45, 210);

/// Starting position of the right player
final startPlayerRight = Vector2(585, 210);

/// Position of the score for the left player
final playerScoreLeft = Vector2(220, 10);

/// Position of the score for the right player
final playerScoreRight = Vector2(420, 10);

/// Size of the player
final playerSize = Vector2(10, 60);

/// Color of the player
final playerPaint = Paint()..color = Colors.white;

/// Size of the ball aka Dash
final dashSize = Vector2.all(30);

/// Start position of the ball
final dashStartPosition = Vector2(320, 230);

/// Inputs for the player
const leftPlayerControlUp = LogicalKeyboardKey.keyW;

/// Inputs for the player
const leftPlayerControlDow = LogicalKeyboardKey.keyS;

/// Inputs for the player
const rightPlayerControlUp = LogicalKeyboardKey.arrowUp;

/// Inputs for the player
const rightlayerControlDown = LogicalKeyboardKey.arrowDown;

/// Input to start the round
const startRoundButton = LogicalKeyboardKey.space;

/// Initial ball speed
const double initialBallSpeed = 100;

/// Points needed to win a match
const winningPoints = 5;

//Random instance for the game
final rnd = Random();

/// Player sides based on the position
enum PlayerSide {
  left,
  right,
}
