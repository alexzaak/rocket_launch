import 'dart:ui';

import 'package:flame/box2d/viewport.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:rocket/levels/space.dart';
import 'package:rocket/world.dart';

class RocketGame extends Game {
  World world = new World();
  Size screenSize;
  double tileSize;

  RocketGame() {


    init();
  }

  void init() async {
    resize(await Flame.util.initialDimensions());
    world.initializeWorld();
  }

  @override
  void render(Canvas canvas) {
    world.render(canvas);
  }

  @override
  void update(double t) {
    world.update(t);
  }

  void onTapDown(TapDownDetails d) {
    world.handleTap(d.globalPosition);
  }

  void onTapUp(TapUpDetails d) {
    //   rocket.onTabUp();
  }

  void onTapCancel() {
    //  rocket.onTabUp();
  }

  @override
  void resize(Size size) {
    world.resize(size);
  }

  void onLongPressDown() {
    world.handlePress(true);
  }

  void onLongPressUp() {
    world.handlePress(false);
  }
}
