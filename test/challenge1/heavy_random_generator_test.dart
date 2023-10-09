import 'package:flutter_test/flutter_test.dart';
import 'package:positive_num/positive_num.dart';
import 'package:spectora_interview_code_flutter/challenge1/heavy_random_generator.dart';

void main() {
  group('HeavyRandomGenerator', () {
    test(
        'generatePositive() generates positive numbers for different seed values',
        () async {
      const seeds = [-7766279331452, 7766279331452, -1, 0, 1, 100, -100];

      for (final seed in seeds) {
        final random = HeavyRandomGenerator.generate((seed: seed, fallback: 1));
        expect(random, isA<PositiveNum<int>>());
        expect(random.value, isPositive);
      }
    });
  });
}
