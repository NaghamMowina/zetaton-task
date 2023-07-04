import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zetaton_task/core/helpers/session_manager.dart';
import 'package:zetaton_task/features/authentication/data/firebase_auth.dart';
import 'package:zetaton_task/features/authentication/model/user_model.dart';

class AuthProvider extends ChangeNotifier {
  bool _showLoading = false;
  bool get showLoading => _showLoading;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  String? _patientPhone;
  String? get patientPhone => _patientPhone;
  set patientPhone(String? value) {
    _patientPhone = value;
    notifyListeners();
  }

  registerUser({UserModel? model}) async {
    try {
      _showLoading = true;
      notifyListeners();
      User? user = await AuthData().registerUser(userModel: model!);
      await getPatientInfo(user!.email!);
      notifyListeners();
      _showLoading = false;
      notifyListeners();
      await setUserInfo(
          id: userModel!.id, name: userModel!.firstname, loggedIn: true);
      notifyListeners();
    } catch (e) {
      _showLoading = false;
      notifyListeners();
      log(e.toString());
    }
  }

  loginUser({required String email, required String password}) async {
    try {
      _showLoading = true;
      notifyListeners();
      User? user = await AuthData()
          .signInUsingEmailPassword(email: email, password: password);
      await getPatientInfo(user!.email!);
      notifyListeners();
      _showLoading = false;
      notifyListeners();
      await setUserInfo(
          id: user.uid, name: userModel!.firstname, loggedIn: true);
      notifyListeners();
    } catch (e) {
      _showLoading = false;
      notifyListeners();
      log(e.toString());
    }
    // getLogged();
    // if (_isLogged) await getPatientInfo(email);
  }

  getPatientInfo(String email) async {
    try {
      _userModel = await AuthData().getUserByEmail(email: email);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  logout() async {
    await setUserInfo(loggedIn: false, id: '0', name: '');
  }

  setUserInfo({bool? loggedIn, String? id, String? name}) async {
    await sessionManager.setLogged(isLogged: loggedIn);
    await sessionManager.setUserId(id: id);
    await sessionManager.setUsername(name: name);
  }
}
