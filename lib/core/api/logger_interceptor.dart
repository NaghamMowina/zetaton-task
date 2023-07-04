import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:zetaton_task/core/constants/app_constants.dart';

class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
    // Customize the printer
    printer: PrettyPrinter(
      methodCount: 0,
      printTime: false,
    ),
  );

  @override
  // ignore: deprecated_member_use
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request => $requestPath'); // Debug log
    logger.d('Error: ${err.error}, Message: ${err.message}'); // Error log
    logger.d('Error: ${err.type}, Message: ${err.response}'); // Error log

    return super.onError(err, handler);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['Authorization'] == false) {
      // if the request doesn't need token, then just continue to the next interceptor
      options.headers.remove('Authorization'); //remove the auxiliary header
      return handler.next(options);
    }
    final requestPath = '${options.baseUrl}${options.path}';
    options.headers['Authorization'] = AppConstants.apiKey;
    options.headers['Accept'] = '*application/json*';
    //options.headers['Accept-Encoding'] = 'gzip, deflate, br';

    logger.i('${options.method} request => $requestPath'); // Info log
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
        'StatusCode: ${response.statusCode}, Data: ${response.data}'); // Debug log
    return super.onResponse(response, handler);
  }
}
