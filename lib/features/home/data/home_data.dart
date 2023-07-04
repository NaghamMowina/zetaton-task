import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:zetaton_task/core/api/apis.dart';
import 'package:zetaton_task/features/home/model/pexel_photo_model.dart';

class HomeData {
  fetchAllPhotos() async {
    try {
      final response = await DioClient().dio.get('curated?per_page=15&page=1',
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          }));
      return PexelPhotosModel.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  searchPhotos({required String query}) async {
    try {
      final response = await DioClient().dio.get(
          "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1",
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          }));
      return PexelPhotosModel.fromJson(response.data);
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }
}
