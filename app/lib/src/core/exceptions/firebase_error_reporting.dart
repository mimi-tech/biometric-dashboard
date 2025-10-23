import 'dart:ui';

import 'package:biometric_app/src/core/exceptions/base_exception.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';

class FirebaseErrorReporting {
  static Future<void> initialize() async {
    // Initialize Firebase Crashlytics
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    // Pass all uncaught asynchronous errors to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      if (error is! BaseException) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      }
      return true;
    };
  }

  static void setUserIdentifier(String userId) {
    FirebaseCrashlytics.instance.setUserIdentifier(userId);
  }

  static void setCustomKey(String key, Object value) {
    FirebaseCrashlytics.instance.setCustomKey(key, value);
  }
}
