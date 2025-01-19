import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class DioLoggingInterceptor extends Interceptor {
  final Logger _logger = Logger('DioLoggingInterceptor');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.info('REQUEST[${options.method}] => PATH: ${options.path}');
    _logger.fine('Request Headers: ${options.headers}');
    _logger.fine('Request Data: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.info(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    _logger.fine('Response Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.severe(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}, MESSAGE: ${err.response?.data}',
      err.error,
      err.stackTrace,
    );
    super.onError(err, handler);
  }
}