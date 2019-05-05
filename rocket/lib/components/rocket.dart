import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

class Rocket extends SpriteComponent {
  static const int SPEED = 200;

  final Sprite _rocketOff = new Sprite('rocket/rocket_off.png');
  final Sprite _rocketOn = new Sprite('rocket/rocket_on.png');

  Rocket() : super.rectangle(110, 177, 'rocket/rocket_off.png') {
    this.angle = 0.0;
    this.x = 0.0;
    this.y = 0.0;
  }

  @override
  void update(double t) {
    // TODO: implement collision
  }

  void onTapDown() {
    this.sprite = _rocketOn;
    this.width=110;
    this.height=246;
  }

  void onTabUp() {
    this.sprite = _rocketOff;
    this.width=110;
    this.height=177;
  }
}
