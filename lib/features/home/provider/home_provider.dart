import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:zetaton_task/features/home/data/home_data.dart';
import 'package:zetaton_task/features/home/model/pexel_photo_model.dart';

class HomeProvider extends ChangeNotifier {
  bool _showLoading = false;
  bool get showLoading => _showLoading;

  PexelPhotosModel? _pexelPhotosModel;
  PexelPhotosModel? get pexelPhotosModel => _pexelPhotosModel;

  fetchPhotosList() async {
    try {
      _showLoading = true;
      //notifyListeners();
      _pexelPhotosModel = await HomeData().fetchAllPhotos();
      notifyListeners();
      _showLoading = false;
      notifyListeners();
    } catch (e) {
      _showLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  fetchSearchPhotosList({required String query}) async {
    try {
      _showLoading = true;
      //notifyListeners();
      _pexelPhotosModel = await HomeData().searchPhotos(query: query);
      notifyListeners();
      _showLoading = false;
      notifyListeners();
    } catch (e) {
      _showLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }
}
