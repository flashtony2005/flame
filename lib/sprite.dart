import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart' show Colors;

class Sprite {
  Image image;
  Rect src;

  static final Paint paint = new Paint()..color = Colors.white;

  Sprite.fromImage(this.image) {
    this.src = new Rect.fromLTWH(0.0, 0.0, image.width.toDouble(), image.height.toDouble());
  }

  Sprite(String fileName, {double x = 0.0, double y = 0.0, double width = -1.0, double height = -1.0}) {
    Flame.images.load(fileName).then((img) {
      if (width == -1.0) {
        width = img.width.toDouble();
      }
      if (height == -1.0) {
        height = img.height.toDouble();
      }
      this.image = img;
      this.src = new Rect.fromLTWH(x, y, width, height);
    });
  }

  bool loaded() {
    return image != null && src != null;
  }

  void renderPosition(Canvas canvas, Position p, Position size) {
    renderRect(canvas, Position.rectFrom(p, size));
  }

  void render(Canvas canvas, double width, double height) {
    renderRect(canvas, new Rect.fromLTWH(0.0, 0.0, width, height));
  }

  void renderRect(Canvas canvas, Rect dst) {
    if (this.loaded()) {
      canvas.drawImageRect(image, src, dst, paint);
    }
  }
}
