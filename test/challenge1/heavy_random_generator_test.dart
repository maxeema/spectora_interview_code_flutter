import 'package:flutter_test/flutter_test.dart';
import 'package:positive_num/positive_num.dart';
import 'package:spectora_interview_code_flutter/challenge1/heavy_random_generator.dart';

void main() {
  group('HeavyRandomGenerator', () {
    test(
        'generate() produces different positive numbers for different seed values',
        () async {
      const seeds = [-7766279331452, 3314527766279, -1, 0, 50, 100];
      final generated = <PositiveInt>[];

      for (final seed in seeds) {
        final random = HeavyRandomGenerator.generate((seed: seed, fallback: 1));
        expect(random, isA<PositiveInt>());
        expect(random.value, isPositive);
        expect(generated, isNot(contains(random)));
        generated.add(random);
      }
    });
  });
}
