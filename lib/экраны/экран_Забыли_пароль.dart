import 'package:flutter/material.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _showPassword = false;
  bool _showPassword2 = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _togglevisibility2() {
    setState(() {
      _showPassword2 = !_showPassword2;
    });
  }

  bool circular = false;

  var confirmPass;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController1 = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();
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
                      SizedBox(height: 20.0),
                      confirmPasswordTextField(),
                      SizedBox(height: 20.0),
                      loginButton(),
                      SizedBox(height: 20.0),
                      backButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget backButton() {
    return Container(
      width: 200,
      height: 45.0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, style: BorderStyle.solid, width: 1.0),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.0)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Center(
            child: Text(
              'GO BACK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
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
              SnackBar snackbar = SnackBar(content: Text("Password Changed"));
              _scaffoldKey.currentState.showSnackBar(snackbar);
              setState(() {
                circular = false;
              });
            } else {
              SnackBar snackbar =
                  SnackBar(content: Text("Issue with changing password"));
              _scaffoldKey.currentState.showSnackBar(snackbar);
              setState(() {
                circular = false;
              });
            }
          },
          child: Center(
            child: circular
                ? ColoredCircularProgressIndicator()
                : Text(
                    'SAVE NEW PASSWORD',
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

  Widget passwordTextField() {
    return TextFormField(
      validator: (String value) {
        confirmPass = value;
        if (value.isEmpty) {
          return "Please Enter New Password";
        } else if (value.length < 8) {
          return "Password must be atleast 8 characters long";
        } else {
          return null;
        }
      },
      controller: _passwordController1,
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
        labelText: 'NEW PASSWORD',
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

  Widget confirmPasswordTextField() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return "Please Re-Enter New Password";
        } else if (value.length < 8) {
          return "Password must be atleast 8 characters long";
        } else if (value != confirmPass) {
          return "Password must be same as above";
        } else {
          return null;
        }
      },
      controller: _passwordController2,
      obscureText: !_showPassword2,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            _togglevisibility2();
          },
          child: Icon(
            _showPassword2 ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
        ),
        labelText: 'Confirm Password',
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
      controller: _emailController,
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
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail_outline_rounded,
          color: Colors.black,
        ),
        labelText: 'EMAIL',
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

  Widget header() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
            child: Text(
              'Reset',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
            child: Text(
              'Password',
              style: TextStyle(
                fontSize: 52.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(240.0, 150.0, 0.0, 0.0),
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
}
