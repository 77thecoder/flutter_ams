import 'package:flutter/material.dart';
import 'package:nvbs_ams/app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'НВБС АМС',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20.0,
          ),
        ),
      ),
      home: LoginPage(title: 'НВБС АМС'),
    );
  }
}

class LoginPage extends StatefulWidget {
  final String title;

  LoginPage({ Key key, this.title }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _loginField = TextFormField(
      controller: loginController,
      obscureText: false,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Login',
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff7C7C7C), width: 2.0),
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Заполните поле Login';
        }
        return null;
      },
      onChanged: (text) {
        print('ssdsd ${text}');
      },
    );

    final _passwordField = TextFormField(
      controller: passwordController,
      obscureText: true,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Password',
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff7C7C7C), width: 2.0),
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Заполните поле Password';
        }
        return null;
      },
    );

    final _loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xffE30613),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            print('login ' + loginController.text);
            print('password ' + passwordController.text);
          }
        },
        child: Text(
          'Login',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(child: Container(
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 80.0,
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
            )
          ),
        )),
      ),
    );
  }
}
