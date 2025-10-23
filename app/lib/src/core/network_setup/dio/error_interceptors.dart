import 'package:dio/dio.dart';

class ErrorInterceptors extends InterceptorsWrapper {
  ErrorInterceptors();

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    super.onError(err, handler);
  }
}
