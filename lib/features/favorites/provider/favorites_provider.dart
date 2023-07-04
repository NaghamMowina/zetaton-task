import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:zetaton_task/core/services/db.dart';
import 'package:zetaton_task/features/favorites/model/favorites_model.dart';

class FavoritesProvider extends ChangeNotifier {
  bool _showLoading = false;
  bool get showLoading => _showLoading;
  // final DB _databaseService = DB();
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  List<FavoritePhotoModel>? _favoritePhotoModel;
  List<FavoritePhotoModel>? get favoritePhotoModel => _favoritePhotoModel;

  fetchfavoritesList() async {
    try {
      _showLoading = true;
      //notifyListeners();
      _favoritePhotoModel = await DB.instance.getFavorites();
      notifyListeners();
      _showLoading = false;
      notifyListeners();
    } catch (e) {
      _showLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  checkIsFavorite({required FavoritePhotoModel favoritePhotoModel}) async {
    try {
      _isFavorite = await DB.instance.checkFavoriteExist(favoritePhotoModel);
      notifyListeners();
    } catch (e) {
      notifyListeners();
      log(e.toString());
    }
  }

  addToFavorites({required FavoritePhotoModel favoritePhotoModel}) async {
    try {
      _showLoading = true;
      //notifyListeners();
      await DB.instance.insertFavorite(favoritePhotoModel);
      checkIsFavorite(favoritePhotoModel: favoritePhotoModel);
      fetchfavoritesList();
      notifyListeners();
      _showLoading = false;
      notifyListeners();
    } catch (e) {
      _showLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  removeFromFavorites({required FavoritePhotoModel favoritePhotoModel}) async {
    try {
      _showLoading = true;
      //notifyListeners();
      await DB.instance.removeFavorite(favoritePhotoModel.photoId);
      checkIsFavorite(favoritePhotoModel: favoritePhotoModel);
      fetchfavoritesList();
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
