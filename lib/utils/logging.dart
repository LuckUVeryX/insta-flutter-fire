import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

final loggerProvider = Provider<Logger>((ref) => AppLogger());

class AppLogger extends Logger {
  AppLogger()
      : super(
          filter: ProductionFilter(),
          printer: PrettyPrinter(
            noBoxingByDefault: true,
            methodCount: 0,
          ),
        );
}

class ProviderLogObserver extends ProviderObserver {
  ProviderLogObserver(this._log);

  final Logger _log;

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    _log.d(
      '''
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"''',
    );
  }
}
