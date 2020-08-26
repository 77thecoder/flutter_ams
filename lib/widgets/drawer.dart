import 'package:flutter/material.dart';
import 'package:nvbs_ams/screens/login_page.dart';
import 'package:nvbs_ams/services/exit.dart';

class DrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Подчиненные'),
            onTap: () {
              //
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Выйти'),
            onTap: () {
              Future<bool> exit = AppService.exit();
              exit.then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())));
            },
          ),
        ],
      ),
    );
  }
}
