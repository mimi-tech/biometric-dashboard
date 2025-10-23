import 'package:dio/dio.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    //
    super.onResponse(response, handler);
  }
}
