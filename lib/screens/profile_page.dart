import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nvbs_ams/models/user_info.dart';
import 'package:nvbs_ams/screens/login_page.dart';
import 'package:nvbs_ams/services/auth_service.dart';
import 'package:nvbs_ams/widgets/drawer.dart';
import 'package:nvbs_ams/services/exit.dart';
import 'package:nvbs_ams/services/ams_request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
  return Column(
    children: <Widget>[
      Container(
        width: 100,
        height: 100,
        child: Avatar(idUser: userInfo.users.first.id),
      ),
      Text(userInfo.users.first.jobStatus),
      Text(userInfo.users.first.fio),
    ],
  );
}

class Avatar extends StatefulWidget {
  final String idUser;

  const Avatar({this.idUser, Key key}) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  String image;
  String _base64;

  @override
  void initState() {
    _getImageUser(widget.idUser);
  }

  Future<String> _getImageUser(_idIser) async {
    AMSRequest ams = new AMSRequest();
    String imageBase64 = await ams.getImageUser(_idIser);

    setState(() {
      _base64 = imageBase64;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_base64 == null)
      return new Container();

    Uint8List bytes = base64.decode(_base64);
    return new Image.memory(bytes);
  }
}

