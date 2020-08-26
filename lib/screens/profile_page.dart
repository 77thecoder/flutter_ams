import 'package:flutter/material.dart';
import 'package:nvbs_ams/screens/login_page.dart';
import 'package:nvbs_ams/widgets/drawer.dart';
import 'package:nvbs_ams/services/exit.dart';
import 'package:nvbs_ams/services/ams_request.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoadingData = false;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  _ProfilePageState() {
    AMSRequest ams = new AMSRequest();
    Future<bool> data = ams.getInfoUser();

    data.then((value) {
      setState(() {
        _isLoadingData = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerApp(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          'Профиль',
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              Future<bool> exit = AppService.exit();
              exit.then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())));
            },
          )
        ],
      ),
      body: Center(
        child: _isLoadingData ? Text('profile') : CircularProgressIndicator(
          backgroundColor: Colors.red,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}