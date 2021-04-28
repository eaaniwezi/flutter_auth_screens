import 'package:auth_screens/%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D1%8B/%D1%8D%D0%BA%D1%80%D0%B0%D0%BD_%D0%97%D0%B0%D0%B1%D1%8B%D0%BB%D0%B8_%D0%BF%D0%B0%D1%80%D0%BE%D0%BB%D1%8C.dart';
import 'package:auth_screens/%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D1%8B/%D1%8D%D0%BA%D1%80%D0%B0%D0%BD_%D1%80%D0%B5%D0%B3%D0%B8%D1%81%D1%82%D1%80%D0%B0%D1%86%D0%B8%D0%B8.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool circular = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              header(),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Form(
                    key: _globalkey,
                    child: Column(
                      children: <Widget>[
                        emailTextField(),
                        SizedBox(height: 20.0),
                        passwordTextField(),
                        SizedBox(height: 5.0),
                        forgetPassword(),
                        SizedBox(height: 40.0),
                        loginButton(),
                        SizedBox(height: 20.0),
                        facebookLogin(),
                      ],
                    ),
                  )),
              SizedBox(height: 15.0),
              register(),
            ],
          ),
        ),
      ),
    );
  }

  Widget register() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Don\'t have an account? ',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        SizedBox(width: 5.0),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return RegistrationScreen();
              }),
            );
          },
          child: Text(
            'Create One',
            style: TextStyle(
                color: Colors.green,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }

  Widget facebookLogin() {
    return GestureDetector(
      onTap: () => print("Still Working on it"),
      child: Container(
        width: 200,
        height: 45.0,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black, style: BorderStyle.solid, width: 1.0),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: ImageIcon(AssetImage('images/image/facebook.png')),
              ),
              SizedBox(width: 10.0),
              Center(
                child: Text('Log in with facebook',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Container(
      width: 200,
      height: 45.0,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        shadowColor: Colors.greenAccent,
        color: Colors.blue,
        elevation: 7.0,
        child: GestureDetector(
          onTap: () {
            setState(() {
              circular = true;
            });
            if (_globalkey.currentState.validate()) {
              SnackBar snackbar =
                  SnackBar(content: Text("Login was Sucessful"));
              _scaffoldKey.currentState.showSnackBar(snackbar);
              setState(() {
                circular = false;
              });
            } else {
              if (!_globalkey.currentState.validate()) {
                SnackBar snackbar =
                    SnackBar(content: Text("Login was not Sucessful"));
                _scaffoldKey.currentState.showSnackBar(snackbar);
                setState(() {
                  circular = false;
                });
              }
            }
          },
          child: Center(
            child: circular
                ? ColoredCircularProgressIndicator()
                : Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
          ),
        ),
      ),
    );
  }

  Widget forgetPassword() {
    return Container(
      alignment: Alignment(1.0, 0.0),
      padding: EdgeInsets.only(top: 15.0, left: 20.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ForgotPassword(),
            ),
          );
        },
        child: Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
            child: Text(
              'No Pain',
              style: TextStyle(
                fontSize: 55.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
            child: Text(
              'No Gain',
              style: TextStyle(
                fontSize: 70.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(260.0, 170.0, 0.0, 0.0),
            child: Text(
              '.',
              style: TextStyle(
                fontSize: 80.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "Please Enter New Password";
        } else if (value.length < 8) {
          return "Password must be atleast 8 characters long";
        } else {
          return null;
        }
      },
      controller: _passwordController,
      obscureText: !_showPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            _togglevisibility();
          },
          child: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
        ),
        labelText: 'Password',
        labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.grey),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget emailTextField() {
    return TextFormField(
      validator: (value) {
        Pattern pattern =
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?)*$";
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(value) || value == null)
          return 'Enter a valid email address';
        if (value.isEmpty) return "Email can't be empty";
        if (!value.contains("@")) return "Invalid Email";
        return null;
      },
      controller: _emailController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail_outline_rounded,
          color: Colors.black,
        ),
        labelText: 'Email',
        labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.grey),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
