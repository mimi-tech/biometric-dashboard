import 'package:biometric_app/src/core/configs/environment/environment_config.dart';

class AppUrl {
  static String baseUrl = EnvironmentConfig.config?.apiBaseUrl ?? '';
  static String googleClientId = EnvironmentConfig.config?.apiBaseUrl ?? '';
}
