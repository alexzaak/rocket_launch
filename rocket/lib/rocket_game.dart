import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:rocket/components/rocket.dart';

class RocketGame extends Game {
  Size screenSize;
  double tileSize;

  Rocket rocket;

  RocketGame() {
    init();
  }

  void init() async {
    resize(await Flame.util.initialDimensions());
    rocket = new Rocket(screenSize);
  }

  @override
  void render(Canvas canvas) {
    rocket.render(canvas);
  }

  @override
  void update(double t) {
    rocket.update(t);
  }

  void onTapDown(TapDownDetails d) {
    rocket.onTapDown();
  }

  void onTapUp(TapUpDetails d) {
    rocket.onTabUp();
  }

  void onTapCancel() {
    rocket.onTabUp();
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }


}
