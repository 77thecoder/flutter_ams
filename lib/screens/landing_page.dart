import 'package:flutter/material.dart';
import 'package:nvbs_ams/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nvbs_ams/screens/profile_page.dart';

class LandingPage extends StatelessWidget {

  Future<bool> _initPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
          context, MaterialPageRoute(builder: (context) => ProfilePage()));
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
