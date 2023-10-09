import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:positive_num/positive_num.dart';
import 'package:spectora_interview_code_flutter/challenge1/heavy_random_generator.dart';
import 'package:spectora_interview_code_flutter/platform_helper.dart';

class HeavyOperationViewModel {
  static const timerInterval = Duration(milliseconds: 1000);

  final Ref ref;

  final valueProvider = StateProvider<PositiveNum<int>?>((ref) => null);

  Timer? _timer;

  HeavyOperationViewModel(this.ref);

  init() {
    _timer ??= Timer.periodic(timerInterval, (timer) async {
      final args = (seed: timer.tick, fallback: 1);
      final PositiveNum<int> total;

      if (PlatformHelper.canUseIsolates) {
        total = await compute(HeavyRandomGenerator.generate, args);
      } else {
        total = HeavyRandomGenerator.generate(args);
      }

      if (timer.isActive) {
        ref.read(valueProvider.notifier).state = total;
      }
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
