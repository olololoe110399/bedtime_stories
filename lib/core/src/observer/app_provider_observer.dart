import 'package:bedtime_stories/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppProviderObservers extends ProviderObserver with LogMixin {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    logD('''
    {
      "provider": "${provider.name ?? provider.runtimeType}",
      "newValue": "$newValue"
    }''');
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    logD('''
    {
      "provider": "${provider.name ?? provider.runtimeType}",
      "newValue": "disposed"
    }''');
    super.didDisposeProvider(provider, container);
  }
}
