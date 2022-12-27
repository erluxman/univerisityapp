import 'package:flutter/material.dart';

extension NumExt on num {
  Widget verticalSpace() {
    return SizedBox(height: toDouble());
  }

  Widget horizontalSpace() {
    return SizedBox(width: toDouble());
  }
}
