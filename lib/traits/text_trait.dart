import 'package:backbone/trait.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

/// All information to render text
class TextTrait extends ATrait {
  bool dirty = false;

  Vector2 _padding = Vector2.zero();
  Vector2 get padding => _padding;
  set padding(Vector2 value) {
    if (value != _padding) {
      _padding = value;
      dirty = true;
    }
  }

  Anchor _anchor = Anchor.topLeft;
  Anchor get anchor => _anchor;
  set anchor(Anchor value) {
    if (value != _anchor) {
      _anchor = value;
      dirty = true;
    }
  }

  String _text = "";
  String get text => _text;
  set text(String value) {
    if (_text != value) {
      _text = value;
      dirty = true;
    }
  }

  TextStyle _style = TextStyle(color: BasicPalette.white.color);
  TextStyle get style => _style;
  set style(TextStyle style) {
    if (style != _style) {
      _style = style;
      dirty = true;
    }
  }
}
