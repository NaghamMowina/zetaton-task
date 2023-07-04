import 'package:shared_preferences/shared_preferences.dart';

class _SessionManager {
  final String loggedIn = 'isLogged';

  final String userId = 'user-id';

  final String userName = 'user-name';

  Future<void> setLogged({bool? isLogged}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(loggedIn, isLogged!);
  }

  Future<bool> getLogged() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isLogged;
    isLogged = pref.getBool(loggedIn) ?? false;
    return isLogged;
  }

  Future<void> setUsername({String? name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userName, name!);
  }

  Future<String> getUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String name;
    name = pref.getString(userName) ?? '';
    return name;
  }

  Future<void> setUserId({String? id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userId, id!);
  }

  Future<String> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id;
    id = pref.getString(userId) ?? '0';
    return id;
  }
}

final sessionManager = _SessionManager();
