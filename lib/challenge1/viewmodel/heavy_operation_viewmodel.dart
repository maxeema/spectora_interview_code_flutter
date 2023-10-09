import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class HeavyOperationViewModel {
  final Ref ref;

  final valueProvider = StateProvider<int>((ref) => 0);

  HeavyOperationViewModel(this.ref);

  init() async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      int total = 0;
      final timet = timer.tick;

      /// Performs an iteration of the specified count
      for (int i = 1; i < 999999999; i++) {
        /// Multiplies each index by the multiplier and computes the total
        total += (i * timet);
      }

      total = total ~/ 1000000;

      ref.read(valueProvider.notifier).state = total;
    });
  }
}
