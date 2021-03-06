import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nvbs_ams/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String API_URL = 'url';

  Future<bool> authAD(String login, String password) async {
    http.Response response;
    bool result;

    try {
      response = await http.post(
        API_URL + '/ad/auth',
        body: {'login': login, 'password': password},
      );
    } catch (error) {
      result = false;
    }

    if (response.statusCode == 200) {
      User user = User.fromJson(json.decode(response.body));
      _saveUser(user);
      result = true;
    } else {
      result = false;
    }

    return Future<bool>.value(result);
  }

  /// Сохраняем инфу о юзеру в локальное хранилище
  void _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('user.isAuth', user.getIsAuth);
    prefs.setString('user.login', user.getLogin);
    prefs.setString('user.tn', user.getTN);
    prefs.setString('user.fio', user.getFIO);
    prefs.setString('user.phones', user.getPhones);
    prefs.setString('user.email', user.getEmail);
    prefs.setString('user.position', user.getPosition);
    prefs.setString('user.department', user.getDepartment);
  }

  /// Проверяем авторизован пользователь или нет
  static Future<bool> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    bool isAuth = prefs.getBool('user.isAuth');
    return Future<bool>.value(isAuth);
  }
}
