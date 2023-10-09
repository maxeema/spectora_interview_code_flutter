/// Waits until the given predicate returns true.
Future<void> untilTrue(bool predicate(), {Duration? checkInterval}) async {
  while (!predicate()) {
    await Future.delayed(checkInterval ?? const Duration(milliseconds: 50));
  }
}
