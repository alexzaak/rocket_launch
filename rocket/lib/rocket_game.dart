import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart'
    show Drag, Offset, TapDownDetails, TapUpDetails;
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
    world.handleTap(d.globalPosition);
  }

  void onTapCancel() {
    //  rocket.onTabUp();
  }

  Drag onDragStart(Offset position) {
    return world.handleDrag(position);
  }

  Drag onDragEnd(Offset position) {
    return world.handleDrag(position);
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
