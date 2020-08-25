import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:nvbs_ams/screens/profile_page.dart';
import 'package:nvbs_ams/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({ Key key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isDisableButton = false;
  bool _isAuth = true;
  bool _obscureText = true;


  @override
  void initState() {
    _checkAuth();
  }

  void _checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("user.isAuth") == true) {
      Navigator.pushNamed(context, '/home');
    }
  }


  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _obscureClick() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
    );

    final _passwordField = TextFormField(
      controller: passwordController,
      obscureText: _obscureText,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Password',
        suffixIcon: Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: GestureDetector(
            onTap: () {
              _obscureClick();
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Color(0xff7C7C7C),
           ),
          )
        ),
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
        onPressed: _isDisableButton ? null : () async {
          setState(() {
            _isLoading = !_isLoading;
            _isDisableButton = !_isDisableButton;
          });

          if (_formKey.currentState.validate()) {
            AuthService auth = new AuthService();
            bool response = await auth.authAD(loginController.text, passwordController.text);

            bool isAuth = response ? true : false;

            setState(() {
              _isAuth = isAuth;
              _isLoading = !_isLoading;
              _isDisableButton = !_isDisableButton;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
          } else {
            setState(() {
              _isLoading = !_isLoading;
              _isDisableButton = !_isDisableButton;
            });
          }
        },
        child: _isLoading ? Container(
          width: 25,
          height: 25,
          child: LoadingIndicator(
            indicatorType: Indicator.ballClipRotate,
            color: Colors.white,
          ),
        ) : Text(
          'Login',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
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
                    ErrorAuth(_isAuth),
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

class ErrorAuth extends StatelessWidget {
  final bool _isAuth;

  ErrorAuth(this._isAuth);

  @override
  Widget build(BuildContext context) {
    if (_isAuth) {
      return SizedBox(height: 1,);
    } else {
      return Padding(
        padding: EdgeInsets.only(bottom: 20),
          child: Text(
            'Неправильный логин или пароль',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold
            ),
        )
      );
    }
//    return _isAuth ? SizedBox(height: 1,) : Text('Неправильный логин или пароль', style: TextStyle(color: Colors.red),);
  }
}
