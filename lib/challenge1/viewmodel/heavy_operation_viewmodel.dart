import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:positive_num/positive_num.dart';
import 'package:spectora_interview_code_flutter/challenge1/heavy_random_generator.dart';
import 'package:spectora_interview_code_flutter/compute_compat.dart';

class HeavyOperationViewModel {
  static const timerInterval = Duration(milliseconds: 1000);

  final Ref ref;

  final valueProvider = StateProvider<PositiveInt?>((ref) => null);

  Timer? _timer;

  HeavyOperationViewModel(this.ref);

  init() {
    _timer ??= Timer.periodic(timerInterval, (timer) async {
      final PositiveInt total;

      total = await ComputeCompat.execute(
        (seed) => Future.value(HeavyRandomGenerator.generate(seed!)),
        timer.tick,
      );

      if (timer.isActive) {
        ref.read(valueProvider.notifier).state = total;
      }
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
