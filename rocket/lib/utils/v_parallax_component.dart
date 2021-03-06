import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flutter/painting.dart';

class VerticalParallaxRenderer {
  String filename;
  Future<Image> future;

  Image image;
  double scroll = 0.0;

  VerticalParallaxRenderer(this.filename) {
    this.future = _load();
  }

  Future<Image> _load() {
    return Flame.images.load(filename).then((image) {
      this.image = image;
    });
  }

  bool loaded() => image != null;

  void render(Canvas canvas, Rect rect) {
    if (image == null) {
      return;
    }

    var imageHeight = image.height / window.devicePixelRatio;
    var imageWidth =
        (rect.height / imageHeight) * (image.width / window.devicePixelRatio);
    var count = rect.height / imageWidth;

    // print("measers: $imageHeight and $imageWidth and $count");

    Rect fullRect = new Rect.fromLTWH(-imageWidth, -rect.height * imageHeight,
        imageWidth + 1200.0, rect.bottom * imageHeight + 800.0);

    Rect fullRect2 = new Rect.fromLTRB(
        -imageWidth, -imageHeight * rect.height, 1200.0,
        scroll * imageHeight * rect.height);

    //  print(fullRect2);

    //  print(rect);

    //   print("scroll $scroll and ${(count + 1)}");

    paintImage(
      canvas: canvas,
      image: image,
      rect: fullRect2,
      repeat: ImageRepeat.repeatY,
    );
  }
}

abstract class VerticalParallaxComponent extends PositionComponent {
  final BASE_SPEED = 25;
  final LAYER_DELTA = 40;

  List<VerticalParallaxRenderer> _layers = new List();
  Size _size;
  bool _loaded = false;

  @override
  void resize(Size size) {
    this._size = size;
  }

  /// Loads the images defined by this list of filenames. All images are positioned at its scroll center.
  ///
  /// @param filenames Image filenames
  void load(List<String> filenames) {
    final futures = filenames.fold(<Future<Image>>[],
            (List<Future<Image>> result, String filename) {
          final layer = new VerticalParallaxRenderer(filename);
          _layers.add(layer);
          result.add(layer.future);
          return result;
        });
    Future.wait(futures).then((r) => _loaded = true);
  }

  void updateScroll(int layerIndex, scroll) {
    _layers[layerIndex].scroll = scroll;
  }

  @override
  bool loaded() {
    return _loaded;
  }

  @override
  void render(Canvas canvas) {
    if (!loaded()) {
      return;
    }

    canvas.save();
    prepareCanvas(canvas);
    _drawLayers(canvas);
    canvas.restore();
  }

  void _drawLayers(Canvas canvas) {
    Rect rect = new Rect.fromPoints(
        const Offset(0.0, 0.0), new Offset(_size.width, _size.height));
    _layers.forEach((layer) => layer.render(canvas, rect));
  }

  @override
  void update(double delta) {
    if (!this.loaded()) {
      return;
    }
    for (int i = 0; i < _layers.length; i++) {
      double scroll = _layers[i].scroll;
      scroll += (BASE_SPEED + 1 * LAYER_DELTA) * delta / _size.height;
      if (scroll > 1) {
        scroll = scroll % 1;
      }

      print("scroll: $scroll");
      _layers[i].scroll = scroll;
    }
  }
}
