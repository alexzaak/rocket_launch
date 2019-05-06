import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flutter/services.dart';
import 'package:rocket/rocket_game.dart';

main() async {
  Flame.initializeWidget();
  Flame.audio.disableLog();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  RocketGame game = new RocketGame();
  runApp(game.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  tapper.onTapUp = game.onTapUp;
  tapper.onTapCancel = game.onTapCancel;
  flameUtil.addGestureRecognizer(tapper);

  LongPressGestureRecognizer longPress = LongPressGestureRecognizer();
  longPress.onLongPress = game.onLongPressDown;
  longPress.onLongPressUp = game.onLongPressUp;

  flameUtil.addGestureRecognizer(longPress);
}