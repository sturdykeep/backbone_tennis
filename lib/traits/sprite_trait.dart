import 'package:backbone/trait.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

/// All information to render a sprite
class SpriteTrait extends ATrait {
  Sprite? sprite;
  Vector2 offset = Vector2.zero();
  Paint paint = Paint();
  int priority = 0;
  bool dirty = true;
  SpriteAnimationData? animationData;
  void Function(int currentIndex)? onFrame;
  void Function()? onComplete;

  void setSprite(Sprite sprite) {
    this.sprite = sprite;
    dirty = true;
  }

  void setAnimation(SpriteAnimationData data) {
    animationData = data;
    dirty = true;
  }

  void set({
    Vector2? offset,
    Paint? paint,
    int? priority,
  }) {
    // Conditionally set properties
    if (offset != null) {
      this.offset = offset;
    }
    if (paint != null) {
      this.paint = paint;
    }
    if (priority != null) {
      this.priority = priority;
    }
    dirty = true;
  }
}
