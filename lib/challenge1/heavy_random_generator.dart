import 'package:positive_num/positive_num.dart';

/// A pseudo-random positive number generator with a seed.
/// The number generation is CPU-heavy, thus it would be better call it
/// in a separate Isolate.
class HeavyRandomGenerator {
  HeavyRandomGenerator._();

  static PositiveNum<int> generate(({int seed, int fallback}) args) {
    var total = 0;

    // Performs an iteration of the specified count
    for (var i = 1; i < 999999999; i++) {
      // Multiplies each index by the multiplier and computes the total
      total += i * args.seed;
    }

    total = total ~/ 1000000;

    final abs = total.abs();

    return PositiveNum.create(abs > 0 ? abs : args.fallback).instance!;
  }
}
