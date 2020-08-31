import 'package:flutter/material.dart';
import 'package:nvbs_ams/models/user_info.dart';
import 'package:nvbs_ams/screens/login_page.dart';
import 'package:nvbs_ams/services/ams_request.dart';
import 'package:nvbs_ams/widgets/avatar.dart';
import 'package:nvbs_ams/widgets/drawer.dart';
import 'package:nvbs_ams/services/exit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:nvbs_ams/widgets/my_list_view.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoadingData = false;
  UserInfo _userInfo;
  Future<bool> isAuth;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  _ProfilePageState() {
    AMSRequest ams = new AMSRequest();
    Future<bool> data = ams.getInfoUser();

    data.then((value) {
      if (value) {
        _getUserInfo();

        setState(() {
          _isLoadingData = value;
        });
      }
    });
  }

  void _getUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String jsonData = pref.get('userInfo');
    _userInfo = await UserInfo.fromJson(json.decode(jsonData));
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
        child: _isLoadingData ? Profile(_userInfo) : CircularProgressIndicator(
          backgroundColor: Colors.red,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}

Widget Profile (UserInfo userInfo) {
  return Center(
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    width: 80,
                    height: 80,
                    child: Avatar(idUser: userInfo.users.first.id),
                  ),
                ),

              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userInfo.users.first.fio,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8,),
                    Text(userInfo.users.first.jobStatus),
                  ],
                ),
              ),
            ),
          ]
        ),
        Container(
          child: MyListView(userInfo: userInfo),
        ),
      ],
    ),
  );
}

