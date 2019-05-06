import 'dart:ui';

import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/gestures.dart';
import 'package:rocket/components/light_years_counter.dart';
import 'package:rocket/components/rocket.dart';
import 'package:rocket/levels/space.dart';

class World extends Box2DComponent {
  Rocket rocket;
  BackgroundComponent backgroundComponent;
  BackgroundComponent2 backgroundComponent2;

  ScoreDisplay scoreDisplay;

  int lightYears = 0;
  int _scors = 0;

  World() : super(scale: 4.0);

  void initializeWorld() {
    backgroundComponent = new BackgroundComponent(this.viewport);
    backgroundComponent2 = new BackgroundComponent2(this.viewport);
    //  add(new BackgroundComponent(this.viewport));
    //add(new GroundComponent(this));
    //addAll(new DemoLevel(this).bodies);
    add(rocket = new Rocket(this));
    scoreDisplay = new ScoreDisplay(this, viewport);
  }

  @override
  void render(Canvas canvas) {
    if (lightYears <= 130) {
      backgroundComponent.render(canvas);
    }

    if (lightYears >= 100) {
      backgroundComponent2.render(canvas);
    }
    super.render(canvas);
    scoreDisplay.render(canvas);
  }

  @override
  void update(t) {
    if (lightYears <= 130) {
      backgroundComponent.update(t);
    } else {
      backgroundComponent.destroy();
    }
    if (lightYears >= 100) {
      backgroundComponent2.update(t);
    }
    super.update(t);
    cameraFollow(rocket, horizontal: 1.5, vertical: 1.5);

    lightYears = (_scors / 100).ceil();
    _scors++;
    scoreDisplay.update(t);
  }

  void handleTap(Offset position) {
    //rocket.engine(true);
    rocket.stop();
  }

  void handlePress(bool pressDown) {
    // rocket.engine(pressDown);
  }

  Drag handleDrag(Offset position) {
    return rocket.handleDrag(position);
  }
}
