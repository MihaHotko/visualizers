@JS()
library anime;

import 'package:js/js.dart';

@JS()
class anime {
  external factory anime(AnimeOptions options);
}

@JS()
@anonymous
class AnimeOptions {
  external factory AnimeOptions({
    targets,
    left,
    right,
    top,
    bottom,
    translateX,
    translateY,
    translateZ,
    rotate,
    rotateX,
    rotateY,
    rotateZ,
    scale,
    scaleX,
    scaleY,
    scaleZ,
    skew,
    skewX,
    skewY,
    perspective,
    value,
    points,
    baseFrequency,
    backgroundColor,
    borderRadius,
    easing,
    loop,
    autoplay,
    direction,
    duration,
    delay,
    endDelay,
    opacity,
  });
  external dynamic get targets;
  external dynamic get left;
  external dynamic get right;
  external dynamic get top;
  external dynamic get bottom;

  //CSS TRANSFORMS
  external dynamic get translateX;
  external dynamic get translateY;
  external dynamic get translateZ;
  external dynamic get rotate;
  external dynamic get rotateX;
  external dynamic get rotateY;
  external dynamic get rotateZ;
  external dynamic get scale;
  external dynamic get scaleX;
  external dynamic get scaleY;
  external dynamic get scaleZ;
  external dynamic get skew;
  external dynamic get skewX;
  external dynamic get skewY;
  external dynamic get perspective;

  //DOM ATTRIBUTES
  external dynamic get value;

  //SVG ATTRIBUTES
  external String get points;
  external num get baseFrequency;

  external dynamic get backgroundColor;
  external dynamic get borderRadius;
  external String get easing;
  external bool get loop;
  external bool get autoplay;
  external String get direction;
  external num get duration;
  external num get delay;
  external num get endDelay;
  external num get opacity;
}
