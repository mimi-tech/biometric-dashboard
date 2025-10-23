import 'package:biometric_app/src/core/configs/environment/app_url.dart';
import 'package:biometric_app/src/core/network_setup/dio/error_interceptors.dart';
import 'package:biometric_app/src/core/network_setup/dio/request_interceptors.dart';
import 'package:biometric_app/src/core/network_setup/dio/response_interceptors.dart';
import 'package:dio/dio.dart';

class DioClient {
  factory DioClient() {
    return _instance;
  }

  DioClient._internal();
  late Dio _dio;

  static final DioClient _instance = DioClient._internal();

  // Make the initialization async to handle the Future<String>
  Future<void> initialize() async {
    _dio = Dio();

    // Resolve the baseUrl asynchronously
    final baseUrl = AppUrl.baseUrl;

    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.contentType = Headers.jsonContentType;

    _dio.options.headers = <String, dynamic>{'Accept': Headers.jsonContentType};

    _dio.interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true),
      RequestInterceptors(),
      ResponseInterceptors(),
      ErrorInterceptors(),
    ]);
  }

  Dio get dio => _dio;
}
