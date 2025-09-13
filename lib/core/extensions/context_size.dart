import 'package:flutter/cupertino.dart';

extension Resizer on BuildContext {

  double getHeight() {
    return MediaQuery
        .of(this)
        .size
        .height;
  }

  double getWidth() {
    return MediaQuery
        .of(this)
        .size
        .width;
  }
}