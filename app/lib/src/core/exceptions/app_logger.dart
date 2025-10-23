import 'package:biometric_app/src/core/configs/environment/environment_config.dart';
import 'package:logger/logger.dart';

abstract final class AppLogger {
  static final _logger = Logger(printer: PrettyPrinter(methodCount: 0));
  static void _logIfNotProduction(void Function() logFunction) {
    if (EnvironmentConfig.isDevMode()) {
      logFunction();
    }
  }

  static void trace(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logIfNotProduction(
      () =>
          _logger.t(message, time: time, error: error, stackTrace: stackTrace),
    );
  }

  static void debug(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logIfNotProduction(
      () =>
          _logger.d(message, time: time, error: error, stackTrace: stackTrace),
    );
  }

  static void info(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logIfNotProduction(
      () =>
          _logger.i(message, time: time, error: error, stackTrace: stackTrace),
    );
  }

  static void warning(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logIfNotProduction(
      () =>
          _logger.w(message, time: time, error: error, stackTrace: stackTrace),
    );
  }

  static void error(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logger.e(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void fatal(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    _logger.f(message, time: time, error: error, stackTrace: stackTrace);
  }
}
