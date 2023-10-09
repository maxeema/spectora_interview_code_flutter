import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class PlatformHelper {
  /// Indicates that the app id ran by Flutter test
  static final bool isFlutterTest =
      Platform.environment.containsKey('FLUTTER_TEST');

  /// Indicates if we can use Isolates or they don't make sense
  static final bool canUseIsolates = !(kIsWeb || isFlutterTest);
}
