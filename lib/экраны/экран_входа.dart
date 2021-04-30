import 'package:auth_screens/%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D1%8B/%D1%8D%D0%BA%D1%80%D0%B0%D0%BD_%D0%97%D0%B0%D0%B1%D1%8B%D0%BB%D0%B8_%D0%BF%D0%B0%D1%80%D0%BE%D0%BB%D1%8C.dart';
import 'package:auth_screens/%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D1%8B/%D1%8D%D0%BA%D1%80%D0%B0%D0%BD_%D1%80%D0%B5%D0%B3%D0%B8%D1%81%D1%82%D1%80%D0%B0%D1%86%D0%B8%D0%B8.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colored_progress_indicators/flutter_colored_progress_indicators.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'экран_начальный.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter/flutter_twitter.dart';
import 'package:http/http.dart' as http;

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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signInFacebook() async {
    FacebookLogin facebookLogin = FacebookLogin();

    final result = await facebookLogin.logIn(['email']);
    final token = result.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
    print(graphResponse.body);
    if (result.status == FacebookLoginStatus.loggedIn) {
      final credential = FacebookAuthProvider.getCredential(accessToken: token);
      _auth.signInWithCredential(credential);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false);
    }
  }

  Future<void> _signInTwitter() async {
    var twitterLogin = new TwitterLogin(
      consumerKey: 'azIqko7qrN5E3f6s2xn6WG1sm',
      consumerSecret: 'sM8O7GFlzZb7hMX7ajg7I0Ti1rkJxZyHnkyqammDzZrJLBIOa6',
    );

    final TwitterLoginResult result = await twitterLogin.authorize();

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        var session = result.session;
        print('successful sign in: ${session.username}');
//        _sendTokenAndSecretToServer(session.token, session.secret);
        break;
      case TwitterLoginStatus.cancelledByUser:
//        _showCancelMessage();
        print('cancelled by user');
        break;
      case TwitterLoginStatus.error:
        print(result.errorMessage);
        break;
    }
  }

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
                  padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                  child: Form(
                    key: _globalkey,
                    child: Column(
                      children: <Widget>[
                        emailTextField(),
                        SizedBox(height: 20.0),
                        passwordTextField(),
                        SizedBox(height: 5.0),
                        forgetPassword(),
                        SizedBox(height: 25.0),
                        loginButton(),
                        SizedBox(height: 20.0),
                        Text(
                          "OR CONTINUE WITH",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            facebookLogin(),
                            // twitterLogin(),
                          ],
                        )
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

  Widget twitterLogin() {
    return GestureDetector(
      onTap: () {
        _signInTwitter();
      },
      child: Container(
        width: 120,
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
                child: ImageIcon(AssetImage('images/image/twitter.png')),
              ),
              SizedBox(width: 10.0),
              Center(
                child: Text(
                  'Twitter',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget facebookLogin() {
    return GestureDetector(
      onTap: () {
        _signInFacebook();
      },
      child: Container(
        width: 120,
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
                child: Text(
                  'Facebook',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              )
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
          onTap: () async {
            setState(() {
              circular = true;
            });
            try {
              if (_globalkey.currentState.validate()) {
                FirebaseUser user =
                    (await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                ))
                        .user;
                if (user != null) {
                  // SharedPreferences prefs =
                  //     await SharedPreferences.getInstance();
                  // prefs.setString('displayName', user.displayName);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                      (route) => false);
                }
              } else {
                setState(() {
                  circular = false;
                });
                SnackBar snackbar =
                    SnackBar(content: Text("Invalid Login Details"));
                _scaffoldKey.currentState.showSnackBar(snackbar);
              }
            } catch (e) {
              print(e);
              // _emailController.text = "";
              // _passwordController.text = "";
              setState(() {
                circular = false;
              });
              SnackBar snackbar = SnackBar(content: Text("Can't login"));
              _scaffoldKey.currentState.showSnackBar(snackbar);
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
