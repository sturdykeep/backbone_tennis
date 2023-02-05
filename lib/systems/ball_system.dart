import 'dart:math';

import 'package:backbone/builders.dart';
import 'package:backbone/filter.dart';
import 'package:backbone/prelude/time.dart';
import 'package:backbone/prelude/transform.dart';
import 'package:backbone/realm.dart';
import 'package:backbone_tennis/game_consts.dart';
import 'package:backbone_tennis/traits/ball_trait.dart';

/// Register the BallTrait & ballSystem
void ballPlugin(RealmBuilder builder) {
  builder.withTrait(BallTrait);
  builder.withSystem(ballSystem);
}

/// Update the ball position if launched or reset to start if not
void ballSystem(Realm realm) {
  final balls = realm.query(Has([BallTrait]));
  final time = realm.getResource<Time>();
  for (final ball in balls) {
    final trait = ball.get<BallTrait>();
    final transform = ball.get<TransformTrait>();
    if (trait.launched == false) {
      transform.position = dashStartPosition;
    }
    transform.position += (trait.direction * trait.speed) * time.delta;
    if (trait.launched) {
      final heading = atan2(trait.direction.y, trait.direction.x);
      transform.rotation = heading;
    } else {
      transform.rotation = 0;
    }
  }
}
