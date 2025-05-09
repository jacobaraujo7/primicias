import 'package:flutter/material.dart';

extension BuildContextRouteExtension on BuildContext {
  Future<T?> push<T>(Widget page, {bool replace = false}) {
    return Navigator.of(
      this,
    ).push<T>(MaterialPageRoute(builder: (context) => page));
  }

  void pop<T>([T? result]) {
    return Navigator.of(this).pop<T>(result);
  }
}
