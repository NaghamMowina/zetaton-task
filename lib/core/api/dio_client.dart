import 'package:dio/dio.dart';
import 'package:zetaton_task/core/constants/app_constants.dart';

import 'apis.dart';

class DioClient {
  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: AppConstants.apiBaseUrl,
            // connectTimeout: 5000,
            // receiveTimeout: 3000,
            responseType: ResponseType.json,
            receiveDataWhenStatusError: true,
            followRedirects: true,
            headers: {
              // 'Accept': '*/*',
              'Authorization': AppConstants.apiKey,
              //'Content-Type': 'application/json',
              //  'Charset': 'utf-8'
            },
          ),
        )..interceptors.addAll([
            AuthorizationInterceptor(),
            LoggerInterceptor(),
          ]);
  late final Dio dio;
}
