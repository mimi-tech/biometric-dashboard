import 'dart:convert';
import 'package:biometric_app/src/core/configs/environment/environment.dart';
import 'package:biometric_app/src/core/configs/environment/environment_config_reader.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';

abstract class EnvironmentConfig {
  static EnvironmentConfigReader? config;
  static bool _isDevMode = false;
  static bool _isStgMode = false;
  static bool _isProdMode = false;

  static Future<void> initialize(String env) async {
    String configString;
    try {
      configString = await rootBundle.loadString('config/$env.json');
    } on Exception catch (_) {
      configString = await rootBundle.loadString(
        'config/${Environment.development}.json',
      );
    }

    config = EnvironmentConfigReader.fromJson(
      json.decode(configString) as Map<String, dynamic>,
    );
    _isDevMode = env == Environment.development;
    _isStgMode = env == Environment.staging;
    _isProdMode = env == Environment.production;
  }

  static bool isDevMode() {
    return _isDevMode;
  }

  static bool isStgMode() {
    return _isStgMode;
  }

  static bool isProdMode() {
    return _isProdMode;
  }
}
