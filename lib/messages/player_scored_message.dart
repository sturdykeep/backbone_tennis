import 'package:backbone/message.dart';
import 'package:backbone_tennis/game_consts.dart';

/// A message to indicate that the given side scored
class PlayerScoredMessage extends AMessage<PlayerSide> {
  final PlayerSide playerSide;

  PlayerScoredMessage({required this.playerSide});
}
