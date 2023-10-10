import 'dart:math';

import 'package:positive_num/positive_num.dart';

/// A pseudo-random positive number generator with a seed.
/// The number generation is CPU-heavy, thus it would be better call it
/// in a separate Isolate.
class HeavyRandomGenerator {
  HeavyRandomGenerator._();

  static PositiveInt generate(int seed) {
    var total = 0;

    // Performs an iteration of the specified count
    for (var i = 1; i < 999999999; i++) {
      // Multiplies each index by the multiplier and computes the total
      total += i * seed;
    }

    total = total ~/ 1000000;

    var result = total.abs();

    if (result <= 0) {
      // In case if the result is 0 or int.abs() somehow returned a negative
      // value (that seems possible according to the documentation),
      // we will provide some random value instead.
      result = Random().nextInt(100) + 1; // add 1 to ensure it will be > 0
    }

    return PositiveInt.create(result).instance!;
  }
}
