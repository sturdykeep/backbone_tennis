import 'package:backbone/trait.dart';
import 'package:backbone_tennis/game_consts.dart';

/// Tag a node to indicate intrest in a player score for a given side
class ScoreTrait extends ATrait {
  final PlayerSide side;

  ScoreTrait({required this.side});
}
