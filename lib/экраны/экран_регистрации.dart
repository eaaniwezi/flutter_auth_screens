import 'package:flutter/material.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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

  var confirmPass;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();

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
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text(
                        'Signup',
                        style: TextStyle(
                            fontSize: 55.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(182.0, 90.0, 0.0, 0.0),
                      child: Text(
                        '.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Form(
                  key: _globalkey,
                  child: Column(
                    children: <Widget>[
                      usernameTextField(),
                      SizedBox(height: 10.0),
                      emailTextField(),
                      SizedBox(height: 10.0),
                      passwordTextField(),
                      SizedBox(height: 20.0),
                      confirmPasswordTextField(),
                      SizedBox(height: 50.0),
                      registerButton(),
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

  Widget registerButton() {
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
              SnackBar snackbar = SnackBar(content: Text("User Registered"));
              _scaffoldKey.currentState.showSnackBar(snackbar);
              setState(() {
                circular = false;
              });
            } else {
              if (!_globalkey.currentState.validate()) {
                SnackBar snackbar = SnackBar(
                    content: Text("User was not Sucessful Registered"));
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
                    'REGISTER',
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
      controller: _passwordController,
      obscureText: !_showPassword,
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

  Widget usernameTextField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) return "Username can't be empty";
        return null;
      },
      controller: _usernameController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: Colors.black,
        ),
        labelText: 'Username',
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
