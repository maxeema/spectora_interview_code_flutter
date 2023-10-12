import 'package:flutter/foundation.dart';
import 'dart:async' ;

import 'package:spectora_interview_code_flutter/runtime_info.dart';

/// A helper class that tries to execute code in a separate Isolate.
/// But it checks if the target Runtime supports it.
///
/// For instance, in Flutter for the Web it will execute code as it is
/// in the main Isolate, because in the web Isolates simply don't work now.
/// But, it is possible to use Web Workers as a solution for web applications.
///
/// Also, if it detects that the code is ran in Flutter widget testing context,
/// then the code also will be executed as it is in the main Isolate.
final class IsolateCompat {
  IsolateCompat._();

  static Future<T> tryCompute<T, A>(Future<T> Function(A? args) isolateFunction,
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

  //TODO here could be a good candidate like to call Isolate.spawn()
  // trySpawn()...
}
