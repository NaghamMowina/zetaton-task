import 'package:dio/dio.dart';
import 'package:zetaton_task/core/constants/app_constants.dart';

// Request methods PUT, POST, PATCH, DELETE needs access token,
// which needs to be passed with "Authorization" header as Bearer token.
class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Authorization'] = AppConstants.apiKey;
    super.onRequest(options, handler);
  }
}
