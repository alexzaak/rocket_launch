import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/painting.dart';
import 'package:rocket/utils.dart';

class Rocket extends BodyComponent {
  static const num ROCKET_RADIUS = 8.0;

  ImagesLoader images = new ImagesLoader();

  bool idle = false;

  bool forward = true;

  Rocket(box2d) : super(box2d) {
    _loadImages();
    _createBody();
  }

  void _loadImages() {
    images.load("rocket_on", "rocket/rocket_on.png");
    images.load("rocket_off", "rocket/rocket_off.png");
  }

  @override
  void update(double t) {
   // print("x ${body.linearVelocity.x.abs()} y ${body.linearVelocity.y.abs()} ${body.linearVelocity.y}");
     this.idle =
        body.linearVelocity.x.abs() < 0.1 && body.linearVelocity.y.abs() < 0.1;
    this.forward = body.linearVelocity.y >= 0.0;
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    if (images.isLoading) {
      return;
    }

    var image = this.idle ? images.get("rocket_off") : images.get("rocket_on");

    paintImage(
        canvas: canvas,
        image: image,
        rect: new Rect.fromCircle(center: center, radius: radius),
        flipHorizontally: false,
        fit: BoxFit.contain);
  }

  void _createBody() {
    final shape = new CircleShape();
    shape.radius = Rocket.ROCKET_RADIUS;
    shape.p.x = 0.0;

    final activeFixtureDef = new FixtureDef();
    activeFixtureDef.shape = shape;
    activeFixtureDef.restitution = 0.0;
    activeFixtureDef.density = 0.05;
    activeFixtureDef.friction = 0.2;
    FixtureDef fixtureDef = activeFixtureDef;

    final activeBodyDef = new BodyDef();
    activeBodyDef.linearVelocity = new Vector2(0.0, 40.0);
    activeBodyDef.position = new Vector2(0.0, 15.0);
    activeBodyDef.type = BodyType.DYNAMIC;
    activeBodyDef.bullet = true;
    BodyDef bodyDef = activeBodyDef;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  void input(Offset position) {
    Vector2 force =
        position.dy < 250 ? new Vector2(0.0, -1.0) : new Vector2(0.0, 1.0);
    body.applyForce(force..scale(10000.0), center);
  }

  void fly() {
    Vector2 force = new Vector2(0.0, 1.0);
    body.applyForce(force..scale(10000.0), center);
  }

  void stop() {
    body.linearVelocity = new Vector2(0.0, 0.0);
    body.angularVelocity = 0.0;
  }

  void engine(bool enabled) {
    this.idle = !enabled;
    forward = enabled;

    if (enabled) {
      Vector2 force = new Vector2(0.0, 3.0);
      body.applyForce(force..scale(10000.0), center);
    }
  }

/*static const int SPEED = 200;

  final Sprite _rocketOff = new Sprite('rocket/rocket_off.png');
  final Sprite _rocketOn = new Sprite('rocket/rocket_on.png');

  Rocket(Size screenSize) : super.rectangle(110, 177, 'rocket/rocket_off.png') {
    this.angle = 0.0;
    this.x = (screenSize.width - 110) / 2;
    this.y = screenSize.height - 246;
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
    this.sprite = _rocketOn;
    this.width = 110;
    this.height = 246;
  }

  void onTabUp() {
    this.sprite = _rocketOff;
    this.width = 110;
    this.height = 177;
  }*/
}
