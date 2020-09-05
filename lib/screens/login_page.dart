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

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final snackBar = SnackBar(
    content: Text('Неверный логин и пароль'),
    backgroundColor: Color(0xffE30613),
  );

  AnimationController _controllerLoginTrue;
  AnimationController _controllerLoginFalse;

  Animation<Offset> _loginFalseAnimation;
  Animation<Offset> _loginTrueAnimation;
  Animation<Offset> _loginFormAnimation;

  bool _isLoading = false;
  bool _isDisableButton = false;
  bool _isAuth;
  bool _obscureText = true;

  // Проверяем аутентифицирован юзер или нет
  void _checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("user.isAuth") == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
    }
  }

  @override
  void initState() {
    super.initState();

    _checkAuth();

    _controllerLoginFalse = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _controllerLoginTrue = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..view;

    _loginFalseAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1, 0.0),
    ).animate(CurvedAnimation(
      parent: _controllerLoginFalse,
      curve: Curves.elasticIn,
    ));

    _loginTrueAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controllerLoginTrue,
      curve: Curves.easeOutSine,
    ));

    _loginFormAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controllerLoginTrue,
      curve: Curves.easeOutSine,
    ));
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    _controllerLoginTrue.dispose();
    _controllerLoginFalse.dispose();
    super.dispose();
  }

  void _obscureClick() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void showInSnackBar() {
   _scaffoldKey.currentState.showSnackBar(snackBar);
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

            _controllerLoginFalse.addListener(() => setState(() {}));
            TickerFuture tickerFuture = _controllerLoginFalse.repeat(reverse: true);
            tickerFuture.timeout(Duration(seconds:  1), onTimeout:  () {
              _controllerLoginFalse.forward(from: 0);
              _controllerLoginFalse.stop(canceled: true);
            });
          });

          if (_formKey.currentState.validate()) {
            AuthService auth = new AuthService();
            Future<bool> response = auth.authAD(loginController.text, passwordController.text);

            response.then((value) {
              setState(() {
                _isAuth = value;
                _isLoading = !_isLoading;
                _isDisableButton = !_isDisableButton;
              });

              if (_isAuth) {
                _controllerLoginFalse.addListener(() => setState(() {}));
                TickerFuture tickerFuture = _controllerLoginTrue.repeat(reverse: true);
                tickerFuture.timeout(Duration(seconds:  2), onTimeout:  () {
                  _controllerLoginTrue.forward(from: 0);
                  _controllerLoginTrue.stop(canceled: true);
                });

                Future.delayed(const Duration(milliseconds: 800), () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                });
              } else {
                showInSnackBar();
              }
            });
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
        ) : SlideTransition(
          position: _loginFalseAnimation,
          child: Text(
            'Login',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
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
                  _isAuth != null && _isAuth ? SlideTransition(
                    position: _loginFormAnimation,
                    child: Column(
                      children: <Widget>[
                        _loginField,
                        SizedBox(height: 25.0,),
                        _passwordField,
                      ],
                    ),
                  ) : Column(
                    children: <Widget>[
                      _loginField,
                      SizedBox(height: 25.0,),
                      _passwordField,
                    ],
                  ),
                  SizedBox(height: 35.0,),
                  _isAuth != null && _isAuth ? SlideTransition(
                      position: _loginTrueAnimation,
                      child: _loginButton,
                  ) : _loginButton,
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


class CustomWidgets {
  CustomWidgets._();
  static buildErrorSnackbar(BuildContext context, String message) {
    print('adfasdasd');
    Scaffold.of(context)
        .showSnackBar(
      SnackBar(
        content: Text("$message"),
      ),
    );
  }
}