import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool circular = false;

  var confirmPass;

  bool _showPassword = false;
  bool _showOldPassword = false;
  bool _showPassword2 = false;

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _togglevisibilityOldPassword() {
    setState(() {
      _showOldPassword = !_showOldPassword;
    });
  }

  void _togglevisibility2() {
    setState(() {
      _showPassword2 = !_showPassword2;
    });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
                padding: EdgeInsets.only(top: 3.0, left: 20.0, right: 20.0),
                child: Form(
                  key: _globalkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      // oldPasswordTextField(),
                      SizedBox(height: 10.0),
                      passwordTextField(),
                      SizedBox(height: 10.0),
                      confirmPasswordTextField(),
                      SizedBox(height: 30.0),
                      savePasswordButton(),
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
        labelText: 'New Password',
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

  Widget oldPasswordTextField() {
    return TextFormField(
      controller: _oldPasswordController,
      obscureText: !_showOldPassword,
      validator: (String value) {
        if (value.isEmpty) {
          return "Please Enter Your Current Password";
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
            _togglevisibilityOldPassword();
          },
          child: Icon(
            _showOldPassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
        ),
        labelText: 'Current Password',
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
        labelText: 'Repeat New Password',
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
              'Change',
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

  Widget savePasswordButton() {
    return GestureDetector(
      onTap: () async {
        setState(() {
          circular = true;
        });
        if (_globalkey.currentState.validate()) {
          var message;
          FirebaseUser user = (await FirebaseAuth.instance.currentUser());
          user
              .updatePassword(_passwordController2.text)
              .then((value) => print("Success"))
              .catchError((onError) => message = 'error');

          SnackBar snackbar =
              SnackBar(content: Text("Password Has Been Changed Successfully"));
          _scaffoldKey.currentState.showSnackBar(snackbar);
          _passwordController.text = "";
          _passwordController2.text = "";
          setState(() {
            circular = false;
          });
        } else {
          setState(() {
            circular = false;
          });
          SnackBar snackbar = SnackBar(content: Text("Invalid Details"));
          _scaffoldKey.currentState.showSnackBar(snackbar);
        }
      },
      child: Container(
        width: 200,
        height: 45.0,
        child: Material(
          borderRadius: BorderRadius.circular(20.0),
          shadowColor: Colors.greenAccent,
          color: Colors.blue,
          elevation: 7.0,
          child: Center(
            child: circular
                ? ColoredCircularProgressIndicator()
                : Text(
                    'UPDATE PASSWORD',
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
}
