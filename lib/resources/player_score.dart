import 'package:backbone_tennis/game_consts.dart';

/// Resource to track the scores of both players
class PlayerScore {
  int _scoreLeftPlayer = 0;
  int _scoreRightPlayer = 0;

  int get scoreLeftPlayer => _scoreLeftPlayer;
  int get scoreRightPlayer => _scoreRightPlayer;

  bool get anySideWonYet =>
      _scoreLeftPlayer == winningPoints || _scoreRightPlayer == winningPoints;

  void playerScored(PlayerSide side) {
    if (side == PlayerSide.left) {
      _scoreLeftPlayer += 1;
    } else {
      _scoreRightPlayer += 1;
    }
  }

  void resetScores() {
    _scoreLeftPlayer = 0;
    _scoreRightPlayer = 0;
  }
}
