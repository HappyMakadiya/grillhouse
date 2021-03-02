import 'dart:ui';
import 'dart:developer' as developer;
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../user_info.dart';
import 'signup_screen.dart';
import '../../Utils/email_validator.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isHidden = true;
  bool _isSignin = false;
  UserInfo _userInfo;

  Future<void> _loginButtonOnPressed(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal);
      pr.style(progressWidget: CupertinoActivityIndicator());

      final email = _emailController.text;
      final password = _passwordController.text;
      _userInfo = UserInfo(email: email, password: password);
      await pr.show();
      try {
        await Amplify.Auth.signOut();
        var signInResult = await Amplify.Auth.signIn(
          username: email,
          password: password,
        );
        _isSignin = signInResult.isSignedIn;
        if (_isSignin) {
          await pr.hide();
          Navigator.of(context).pushReplacementNamed('/home_screen');
        }
      }on UserNotFoundException catch(e){
        await pr.hide();
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("Email is not registered"),
          ),
        );
      }on NotAuthorizedException catch (e) {
        await pr.hide();
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("Incorrect Email and Password"),
          ),
        );
      } on UserNotConfirmedException catch(e){
        await pr.hide();
        Navigator.of(context).pushNamed('/verify_email', arguments: _userInfo );
      }  catch(e){
        await pr.hide();
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("Something Went Wrong! Try again later."),
          ),
        );
      }

    }
  }

  Future<void> _signUpButtonOnPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }


  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {

    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stack(
                children: [
                  Column(
                    children: [
                      // Image(
                      //   image: AssetImage('assets/images/chef.png'),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, top: 100),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Open Sans',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40,100,40,0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Theme.of(context).primaryColor,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                          ),
                          controller: _emailController,
                          validator: (value) =>
                          !validateEmail(value) ? "Email is Invalid" : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40,20,40,0),
                        child: TextFormField(
                          obscureText: _isHidden,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            suffix: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(
                                _isHidden ? Icons.visibility : Icons.visibility_off,
                              ),
                            ),
                          ),
                          controller: _passwordController,
                          validator: (value) =>
                          value.isEmpty || value.length < 8 ? "Password is invalid" : null,
                        ),
                      ),
                      SizedBox(
                        height:30,
                      ),
                      FlatButton(
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => _loginButtonOnPressed(context),
                        minWidth: 130,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        color: Theme.of(context).primaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () => _signUpButtonOnPressed(context),
                          child: new Text("Don't have account? Sign up"),
                        ),
                      ),
                    ],
                  ),
                ]

            ),
          ),
        ),
      ),
    );
  }
}
