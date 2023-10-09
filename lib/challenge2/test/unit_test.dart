// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectora_interview_code_flutter/challenge1/providers/viewmodel_providers.dart';
import 'package:spectora_interview_code_flutter/challenge1/viewmodel/heavy_operation_viewmodel.dart';

void main() {
  late ProviderContainer container;
  late HeavyOperationViewModel subject;

  setUpAll(() async {
    container = ProviderContainer();
    subject = container.read(ViewModelProviders.heavyOperationViewModel);
  });

  tearDownAll(() async {
    container.dispose();
  });

  test('value should not be 0', () async {
    expect(subject, isNotNull);

    // This is how you can read the value from the provider
    //final value = container.read(subject.valueProvider);
  });
}
