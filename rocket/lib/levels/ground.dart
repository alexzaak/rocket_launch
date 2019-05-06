
import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/components/parallax_component.dart';

class GroundComponent extends BodyComponent {
  static final HEIGHT = 6.20;

  ParallaxRenderer parallax;

  GroundComponent(Box2DComponent box) : super(box) {
    this.parallax = new ParallaxRenderer("layers/background.png");
    _createBody();
  }

  void _createBody() {
    final shape = new PolygonShape();
    shape.setAsBoxXY(100000.0, HEIGHT);
    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.0;
    fixtureDef.friction = 0.8;

    final bodyDef = new BodyDef();
    bodyDef.position = new Vector2(0.0, -16.0);
    Body groundBody = world.createBody(bodyDef);
    groundBody.createFixtureFromFixtureDef(fixtureDef);
    this.body = groundBody;
  }

  @override
  void update(double t) {
    if (!parallax.loaded()) {
      return;
    }

// TODO: abstract this
    var screens =
        parallax.image.width / viewport.size.width / window.devicePixelRatio;

    parallax.scroll =
        viewport.getCenterHorizontalScreenPercentage(screens: screens);
  }

  @override
  void renderPolygon(Canvas canvas, List<Offset> points) {
    if (!parallax.loaded()) {
      return;
    }

    var left = 0.0;
    var top = points[2].dy;
    var right = viewport.size.width;
    var bottom = points[0].dy;
    var rect = new Rect.fromLTRB(left, top, right, bottom);
    parallax.render(canvas, rect);
  }
}