// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:positive_num/positive_num.dart';
import 'package:spectora_interview_code_flutter/challenge1/providers/viewmodel_providers.dart';

import 'package:spectora_interview_code_flutter/challenge1/viewmodel/heavy_operation_viewmodel.dart';

import '../../test_helpers.dart';

void main() {
  group('HeavyOperationViewModel', () {
    late ProviderContainer container;
    late HeavyOperationViewModel model;

    setUp(() {
      container = ProviderContainer();
      model = container.read(ViewModelProviders.heavyOperationViewModel);
    });

    tearDown(() {
      model.dispose();
      container.dispose();
    });

    test('model has no value then generates new numbers', () async {
      const numbersToGenerate = 2;

      // Ensure value provider has no value
      expect(container.read(model.valueProvider), null);

      // Init model
      model.init();

      final generated = <PositiveInt>[];

      late final ProviderSubscription<PositiveInt?> subscription;
      subscription = container.listen(model.valueProvider, (previous, next) {
        expect(next, isNotNull);
        generated.add(next!);
        if (generated.length == numbersToGenerate) {
          subscription.close();
        }
      });

      expect(generated.length, 0);

      await untilTrue(() {
        return generated.length == numbersToGenerate;
      });

      // Ensure model generated N numbers
      expect(generated.length, numbersToGenerate);

      // Ensure value provider has a value
      expect(container.read(model.valueProvider), isNotNull);
    });
  });
}
