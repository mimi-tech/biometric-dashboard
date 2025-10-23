import 'package:biometric_app/firebase_options.dart';
import 'package:biometric_app/src/core/configs/environment/environment.dart';
import 'package:biometric_app/src/core/configs/environment/environment_config.dart';
import 'package:biometric_app/src/core/configs/locator.dart';
import 'package:biometric_app/src/core/exceptions/firebase_error_reporting.dart';
import 'package:biometric_app/src/core/network_setup/dio/dio_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppConfig {
  Future<void> appInitSetup(String env) async {
    WidgetsFlutterBinding.ensureInitialized();

    await EnvironmentConfig.initialize(env);

    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // Note: For testing purposes, Firebase is currently configured in development mode
    // and shared across all environments. In production, each environment should have
    // its own separate Firebase configuration.

    if (env == Environment.production) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } else if (env == Environment.staging) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } else {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    await FirebaseErrorReporting.initialize();
    setupLocator();
    await getIt.allReady();

    await DioClient().initialize();
  }
}
