import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:spectora_interview_code_flutter/runtime_info.dart';

/// A helper class that tries to execute code in a separate Isolate
/// by calling compute(). But it checks if the target Runtime supports it.
///
/// For instance, in Flutter for the Web it will execute code as it is
/// in the main Isolate, because currently in web Isolates simply don't work,
/// but it's possible to use Web Workers.
///
/// Also, if it's detected that the code is ran on in Flutter widget testing
/// context, then the code also will be executed as is in the main Isolate.
final class ComputeCompat {
  ComputeCompat._();

  static Future<T> execute<T, A>(Future<T> Function(A? args) isolateFunction,
      [A? args]) {
    if (RuntimeInfo.canUseIsolates) {
      return compute(isolateFunction, args);
    } else {
      if (!RuntimeInfo.isFlutterTest) {
        debugPrint(
          "Warning. Can't execute a function in a separate Isolate,"
          " continue with the main.",
        );
      }
      return isolateFunction(args);
    }
  }
}
