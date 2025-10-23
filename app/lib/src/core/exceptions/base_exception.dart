import 'dart:convert';
import 'package:biometric_app/src/core/configs/environment/environment_config.dart';
import 'package:biometric_app/src/core/exceptions/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

enum LayersType { data, bloc, service }

bool overrideProdInTests = false;

// error_types.dart
enum ErrorType {
  urlLaunchError,
  parsingError,
  serverError,
  serviceError,
  unknownError,
  analyticError,
  networkError,
  timeoutError,
  badCertificate,
  authenticationError,
  validationError,
  businessLogicError,
}

// base_exception.dart

class BaseException implements Exception {
  BaseException({
    required this.error,
    required this.className,
    required this.errorType,
    this.stackTrace,
    this.layer,
    this.isInternalError = true,
    this.additionalData,
  }) {
    _logAndReportError();
  }
  final Object error;
  final StackTrace? stackTrace;
  final LayersType? layer;
  final ErrorType errorType;
  final String? className;
  final bool isInternalError;
  final Map<String, dynamic>? additionalData;

  void _logAndReportError() {
    final traceString = stackTrace?.toString().split('\n').first ?? '';
    final fileName = _extractFileName(traceString);
    final isProdMode =
        EnvironmentConfig.isProdMode() && !kDebugMode || overrideProdInTests;
    final errorMessage = _generateErrorMessage();

    // Log error locally
    AppLogger.error(
      errorMessage,
      error: error.toString(),
      stackTrace: stackTrace,
    );

    // Report to Firebase Crashlytics in production
    if (isProdMode) {
      _reportToFirebase(errorMessage, fileName);
    }
  }

  String _extractFileName(String traceString) {
    try {
      return traceString.split(' ').last.split('/').last.split(':').first;
    } catch (e) {
      return 'unknown_file';
    }
  }

  String _generateErrorMessage() {
    switch (errorType) {
      case ErrorType.urlLaunchError:
        return '$error';
      case ErrorType.parsingError:
        return '$error';
      case ErrorType.serverError:
        return '$error';
      case ErrorType.serviceError:
        return '$error';
      case ErrorType.networkError:
        return '$error';
      case ErrorType.timeoutError:
        return '$error';
      case ErrorType.authenticationError:
        return '$error';
      case ErrorType.validationError:
        return '$error';
      case ErrorType.analyticError:
        return '$error';
      case ErrorType.unknownError:
        return '$error';
      case ErrorType.badCertificate:
        return 'Bad Certificate Error';
      case ErrorType.businessLogicError:
        return 'Business Logic Error';
    }
  }

  Future<void> _reportToFirebase(String errorMessage, String fileName) async {
    try {
      final firebaseError = {
        'message': errorMessage,
        'layer': layer ?? 'Unknown',
        'className': className ?? 'Unknown',
        'fileName': fileName,
        'errorType': errorType.toString(),
        'isInternalError': isInternalError,
        'timestamp': DateTime.now().toIso8601String(),
        ...?additionalData,
      };

      // Record the error
      await FirebaseCrashlytics.instance.recordError(
        errorMessage,
        stackTrace,
        fatal: isInternalError,
        information: [
          DiagnosticsProperty('errorType', errorType.toString()),
          DiagnosticsProperty('layer', layer),
          DiagnosticsProperty('className', className),
        ],
      );

      // Set custom keys for better filtering
      await FirebaseCrashlytics.instance.setCustomKey(
        'error_type',
        errorType.toString(),
      );
      await FirebaseCrashlytics.instance.setCustomKey(
        'layer',
        layer ?? 'unknown',
      );
      await FirebaseCrashlytics.instance.setCustomKey(
        'class_name',
        className ?? 'unknown',
      );
      await FirebaseCrashlytics.instance.setCustomKey(
        'error_details',
        jsonEncode(firebaseError),
      );

      // Log the error message
      await FirebaseCrashlytics.instance.log(errorMessage);
    } catch (firebaseError) {
      // Fallback logging if Firebase fails
      debugPrint('Failed to report to Firebase: $firebaseError');
    }
  }

  @override
  String toString() {
    return _generateErrorMessage();
  }

  // Helper method to get user-friendly error message
  String get userFriendlyMessage {
    switch (errorType) {
      case ErrorType.networkError:
        return 'Please check your internet connection and try again.';
      case ErrorType.serverError:
        return 'Something went wrong on our end';
      case ErrorType.timeoutError:
        return 'Request timed out.';
      case ErrorType.authenticationError:
        return 'Authentication failed. Please log in again.';
      case ErrorType.validationError:
        return 'Please check your input and try again.';
      case ErrorType.urlLaunchError:
        return 'Unable to launch URL';
      case ErrorType.parsingError:
        return 'Unable to parse model';
      case ErrorType.serviceError:
        return 'Service Error';
      case ErrorType.unknownError:
        return 'unknownError Error';
      case ErrorType.analyticError:
        return 'Analytic Error';
      case ErrorType.badCertificate:
        return 'Bad Certificate Error';
      case ErrorType.businessLogicError:
        return 'Business Logic Error';
    }
  }
}

// dio_service_exception.dart
class DioServiceException extends BaseException {
  DioServiceException({
    required super.error,
    required String super.className,
    super.stackTrace,
    ErrorType? errorType,
    bool? isInternalError,
    super.additionalData,
  }) : super(
         layer: LayersType.service,
         errorType: errorType ?? _determineErrorType(error),
         isInternalError: isInternalError ?? false,
       );

  static ErrorType _determineErrorType(Object error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('timeout')) {
      return ErrorType.timeoutError;
    } else if (errorString.contains('network') ||
        errorString.contains('connection')) {
      return ErrorType.networkError;
    } else if (errorString.contains('unauthorized') ||
        errorString.contains('authentication')) {
      return ErrorType.authenticationError;
    } else if (errorString.contains('validation') ||
        errorString.contains('bad request')) {
      return ErrorType.validationError;
    } else {
      return ErrorType.serverError;
    }
  }
}

// service_exception.dart
class ServiceException extends BaseException {
  ServiceException({
    required super.error,
    required String super.className,
    super.stackTrace,
    ErrorType? errorType,
    bool? isInternalError,
    super.additionalData,
  }) : super(
         layer: LayersType.service,
         errorType: errorType ?? ErrorType.serviceError,
         isInternalError: isInternalError ?? true,
       );
}

// bloc_exception.dart
class BlocException extends BaseException {
  BlocException({
    required super.error,
    required String super.className,
    super.stackTrace,
    ErrorType? errorType,
    bool? isInternalError,
    super.additionalData,
  }) : super(
         layer: LayersType.bloc,
         errorType: errorType ?? ErrorType.businessLogicError,
         isInternalError: isInternalError ?? true,
       );
}

// Analytics error
class AnalyticsException extends BaseException {
  AnalyticsException({
    required super.error,
    required String super.className,
    super.stackTrace,
    ErrorType? errorType,
    bool? isInternalError,
    super.additionalData,
  }) : super(
         errorType: errorType ?? ErrorType.analyticError,
         isInternalError: isInternalError ?? true,
       );
}

// bloc_exception.dart
class UrlException extends BaseException {
  UrlException({
    required super.error,
    required String super.className,
    super.stackTrace,
    ErrorType? errorType,
    bool? isInternalError,
    super.additionalData,
  }) : super(
         errorType: errorType ?? ErrorType.urlLaunchError,
         isInternalError: isInternalError ?? true,
       );
}

// parsing_exception.dart
class ParsingException extends BaseException {
  ParsingException({
    required super.error,
    required String super.className,
    super.stackTrace,
    super.additionalData,
  }) : super(
         layer: LayersType.data,
         errorType: ErrorType.parsingError,
         isInternalError: true,
       );
}

// parsing_exception.dart
class GeneralException extends BaseException {
  GeneralException({
    required super.error,
    String? className,
    super.stackTrace,
    super.additionalData,
  }) : super(
         className: className ?? 'Unknown',
         errorType: ErrorType.unknownError,
         isInternalError: true,
       );
}

// parsing_exception.dart
class ExceedException extends BaseException {
  ExceedException({
    required super.error,
    String? className,
    super.stackTrace,
    super.additionalData,
  }) : super(
         className: className ?? 'Unknown',
         errorType: ErrorType.unknownError,
         isInternalError: true,
       );
}

// exception_handler.dart

class ExceptionHandler {
  // Handle Dio exceptions specifically
  static BaseException handleDioException(
    DioException dioError,
    String className, {
    Map<String, dynamic>? additionalData,
  }) {
    Object? error;
    ErrorType errorType;

    // Safely extract error message
    try {
      // ignore: avoid_dynamic_calls
      error =
          dioError.response?.data?['message'] ??
          dioError.response?.data ??
          dioError.message ??
          'Unknown server error';
    } catch (e) {
      error = dioError.message ?? 'Failed to parse server response';
    }

    // Determine error type based on status code
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorType = ErrorType.timeoutError;
      case DioExceptionType.connectionError:
        errorType = ErrorType.networkError;
      case DioExceptionType.badResponse:
        errorType = _getErrorTypeFromStatusCode(dioError.response?.statusCode);
      case DioExceptionType.cancel:
        errorType = ErrorType.unknownError;
        error = 'Request was cancelled';
      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
        errorType = ErrorType.badCertificate;
    }

    return DioServiceException(
      error: error ?? 'Unknown Error',
      className: className,
      stackTrace: dioError.stackTrace,
      errorType: errorType,
      additionalData: {
        'statusCode': dioError.response?.statusCode,
        'requestPath': dioError.requestOptions.path,
        'method': dioError.requestOptions.method,
        ...?additionalData,
      },
    );
  }

  static ErrorType _getErrorTypeFromStatusCode(int? statusCode) {
    if (statusCode == null) return ErrorType.unknownError;

    switch (statusCode) {
      case 400:
        return ErrorType.validationError;
      case 401:
      case 403:
        return ErrorType.authenticationError;
      case >= 500:
        return ErrorType.serverError;
      default:
        return ErrorType.serverError;
    }
  }

  // Handle bloc exceptions
  static BaseException handleBlocException(
    Object error,
    StackTrace stackTrace,
    String className, {
    ErrorType? errorType,
    LayersType? layer,
    Map<String, dynamic>? additionalData,
  }) {
    return BlocException(
      error: error,
      className: className,
      stackTrace: stackTrace,
      errorType: errorType,
      additionalData: additionalData,
    );
  }

  // Handle service exceptions
  static BaseException handleServiceException(
    Object error,
    StackTrace stackTrace,
    String className, {
    ErrorType? errorType,
    LayersType? layer,
    Map<String, dynamic>? additionalData,
  }) {
    return ServiceException(
      error: error,
      className: className,
      stackTrace: stackTrace,
      errorType: errorType,
      additionalData: additionalData,
    );
  }

  // Handle url exceptions
  static BaseException handleUrlException(
    Object error,
    StackTrace stackTrace,
    String className, {
    ErrorType? errorType,
    LayersType? layer,
    Map<String, dynamic>? additionalData,
  }) {
    return UrlException(
      error: error,
      className: className,
      stackTrace: stackTrace,
      errorType: errorType,
      additionalData: additionalData,
    );
  }

  // Handle analytics exceptions
  static BaseException handleAnalyticsException(
    Object error,
    StackTrace stackTrace,
    String className, {
    ErrorType? errorType,
    LayersType? layer,
    Map<String, dynamic>? additionalData,
  }) {
    return AnalyticsException(
      error: error,
      className: className,
      stackTrace: stackTrace,
      errorType: errorType,
      additionalData: additionalData,
    );
  }

  // Handle format exceptions
  static BaseException handleFormatException(
    Object error,
    StackTrace stackTrace,
    String? className, {
    ErrorType? errorType,
    LayersType? layer,
    Map<String, dynamic>? additionalData,
  }) {
    return ParsingException(error: error, className: className ?? '');
  }

  // Handle analytics exceptions
  static BaseException handleGeneralException(
    Object error, {
    StackTrace? stackTrace,
    String? className,
    ErrorType? errorType,
    LayersType? layer,
    Map<String, dynamic>? additionalData,
  }) {
    return GeneralException(
      error: error,
      additionalData: additionalData,
      className: className ?? 'Unknown',
    );
  }

  // Handle Exceeded exceptions
  static BaseException handleExceededException(
    Object error, {
    StackTrace? stackTrace,
    String? className,
    ErrorType? errorType,
    LayersType? layer,
    Map<String, dynamic>? additionalData,
  }) {
    return GeneralException(
      error: error,
      additionalData: additionalData,
      className: className ?? 'Unknown',
    );
  }
}
