import 'package:flutter/material.dart';
import 'package:nvbs_ams/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nvbs_ams/screens/profile_page.dart';

class LandingPage extends StatelessWidget {
  String _login;

  Future<bool> _initPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _login = prefs.getString('user.login');
    return prefs.getBool('user.isAuth');
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> isAuth = _initPage();

    isAuth.then((value) {
      if (value == null || !value) {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else if (value) {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfilePage(login: _login)));
      }
    });

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
