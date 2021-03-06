import 'dart:math';

import 'package:flame/box2d/viewport.dart';
import 'package:rocket/utils/v_parallax_component.dart';

class BackgroundComponent extends VerticalParallaxComponent {
  Viewport viewport;

  BackgroundComponent(this.viewport) {
    _loadImages();
    resize(viewport.size);
  }

  void _loadImages() {
    var filenames = new List<String>();
    filenames.add("layers/background.png");
    filenames.add("layers/stars.png");
    filenames.add("layers/far_planets.png");
    filenames.add("layers/ring_planet.png");
    filenames.add("layers/big_planet.png");

    load(filenames);
  }

  @override
  void update(double t) {
    if (!loaded()) {
      return;
    }
//super.update(t);
    // this.y += 1;

    for (var i = 1; i <= 5; i++) {
      if (i <= 2) {
        updateScroll(i - 1, 0.5);
        continue;
      }
      int screens = pow(8 - i, 2);

      var scroll = viewport.getCenterHorizontalScreenPercentage(
          screens: screens.toDouble()) * 0.005;
      print("${i - 1} scroll: $scroll and ${screens.toDouble()}");
      updateScroll(i - 1, scroll);
    }
  }
}

class BackgroundComponent2 extends VerticalParallaxComponent {
  Viewport viewport;

  BackgroundComponent2(this.viewport) {
    _loadImages();
    resize(viewport.size);
  }

  void _loadImages() {
    var filenames = new List<String>();
    filenames.add("layers/background2.png");
    filenames.add("layers/stars.png");
    filenames.add("layers/far_planets.png");
    filenames.add("layers/ring_planet.png");
    filenames.add("layers/big_planet.png");

    load(filenames);
  }

  @override
  void update(double t) {
    if (!loaded()) {
      return;
    }

    // this.y += 1;

    for (var i = 1; i <= 5; i++) {
      if (i <= 2) {
        updateScroll(i - 1, 0.5);
        continue;
      }
      int screens = pow(6 - i, 3);

      var scroll = viewport.getCenterHorizontalScreenPercentage(
          screens: screens.toDouble());
      updateScroll(i - 1, scroll);
    }
  }
}
