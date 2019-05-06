import 'dart:ui';

import 'package:flame/components/component.dart';

class Platform extends SpriteComponent {
  static const int SPEED = 200;


  Platform(Size screenSize) : super.rectangle(334, 114, 'rocket/platform.png') {
    this.angle = 0.0;
    this.x = (screenSize.width - 334) / 2;
    this.y = screenSize.height - 114;
  }

  @override
  void update(double t) {
    // TODO: implement collision
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  void onTapDown() {
  }

  void onTabUp() {
  }
}