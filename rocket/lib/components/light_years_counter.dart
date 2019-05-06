import 'package:flame/box2d/viewport.dart';
import 'package:flame/components/component.dart';
import 'package:flutter/painting.dart';
import 'package:rocket/world.dart';

class ScoreDisplay {

  World world;
  Viewport viewport;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  ScoreDisplay(this.world, this.viewport) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 90,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
    if ((painter.text?.text ?? '') != world.lightYears.toString()) {
      painter.text = TextSpan(
        text: world.lightYears.toString(),
        style: textStyle,
      );

      painter.layout();

      position = Offset(
        (viewport.size.width / 2) - (painter.width / 2),
        (viewport.size.height * .25) - (painter.height / 2),
      );
    }
  }
}