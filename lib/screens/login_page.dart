import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String title;

  LoginPage({ Key key, this.title }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _loginField = TextField(
      obscureText: false,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Login',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final _passwordField = TextField(
      obscureText: true,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final _loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text(
          'Login',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    'assets/images/logo_nvbs.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0,),
                _loginField,
                SizedBox(height: 25.0,),
                _passwordField,
                SizedBox(height: 35.0,),
                _loginButton,
                SizedBox(height: 15.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
