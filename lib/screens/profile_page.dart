import 'package:flutter/material.dart';
import 'package:nvbs_ams/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Профиль',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('user.isAuth');
              prefs.remove('user.login');
              prefs.remove('user.tn');
              prefs.remove('user.fio');
              prefs.remove('user.email');
              prefs.remove('user.position');
              prefs.remove('user.department');
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
          )
        ],
      ),
      body: Center(
        child: Text('profile'),
      ),
    );
  }
}
