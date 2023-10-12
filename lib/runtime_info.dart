import 'package:flutter/foundation.dart';

import 'package:universal_io/io.dart';

abstract class RuntimeInfo {
  /// Indicates that code is ran by the Flutter test framework
  static final bool isFlutterTest =
      Platform.environment.containsKey('FLUTTER_TEST');

  /// Indicates if we can use Isolates or they don't make sense.
  /// In Fluter web there is only a way to use Web Workers.
  /// In Flutter widget testing executing code "await compute()"
  /// will lead to nothing (await call won't just finish).
  static final bool canUseIsolates = !(kIsWeb || isFlutterTest);
}
