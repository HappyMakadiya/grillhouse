import 'dart:ui';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:grillhouse/models/ModelProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../user_info.dart';
import 'signup_screen.dart';
import '../../Utils/email_validator.dart';

class LoginScreen extends StatefulWidget {
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
  UserInfoData _userInfo;
  var userName = "";
  var userEmail = "";
    var userID = "";
    
 
  Future<void> getData() async {
    var attribute = await Amplify.Auth.fetchUserAttributes();
    var nameIndex =
        attribute.indexWhere((element) => element.userAttributeKey == 'name');
    var emailIndex =
        attribute.indexWhere((element) => element.userAttributeKey == 'email');
    var idIndex =
        attribute.indexWhere((element) => element.userAttributeKey == 'sub');
      userName = attribute[nameIndex].value.toString();
      userEmail = attribute[emailIndex].value.toString();
      userID = attribute[idIndex].value.toString();
  }
 Future<void> addToSharedPrefData() async {
    await getData();
    User oldUser = (await Amplify.DataStore.query(User.classType, where: User.EMAIL.eq(userEmail)))[0];
    User newUser = oldUser.copyWith(id: oldUser.id, cognito_user_id: userID);
    await Amplify.DataStore.save(newUser);
    SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('userName', userName);
     prefs.setString('userEmail', userEmail);
     prefs.setString('userID', userID);
  }

  Future<void> _loginButtonOnPressed(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      final ProgressDialog pr =
          ProgressDialog(context, type: ProgressDialogType.Normal);
      pr.style(progressWidget: CupertinoActivityIndicator());
      final email = _emailController.text;
      final password = _passwordController.text;
      _userInfo = UserInfoData(email: email, password: password);
      await pr.show();
      try {
        await Amplify.Auth.signOut();
        var signInResult = await Amplify.Auth.signIn(
          username: email,
          password: password,
        );
        _isSignin = signInResult.isSignedIn;
        if (_isSignin) {
          await addToSharedPrefData();
          await pr.hide();
          Navigator.of(context).pushReplacementNamed('/navbar');
        }
      } on UserNotFoundException catch (e) {
        await pr.hide();
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("Email is not registered"),
          ),
        );
      } on NotAuthorizedException catch (e) {
        await pr.hide();
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("Incorrect Email and Password"),
          ),
        );
      } on UserNotConfirmedException catch (e) {
        await pr.hide();
        Navigator.of(context).pushNamed('/verify_email', arguments: _userInfo);
      } catch (e) {
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
            child: Stack(children: [
              ClipPath(
                clipper: OuterClipperPart(),
                child: Container(
                  color: Theme.of(context).primaryColor,
                  width: scrWidth,
                  height: scrHeight,
                ),
              ),
              ClipPath(
                clipper: InnerClipperPart(),
                child: Container(
                  color: Color(0xffb37805),
                  width: scrWidth,
                  height: scrHeight,
                ),
              ),
              Column(
                children: [
                  // Image(
                  //   image: AssetImage('assets/images/chef.png'),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 220),
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
                    padding: const EdgeInsets.fromLTRB(40, 70, 40, 0),
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
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
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
                      validator: (value) => value.isEmpty || value.length < 8
                          ? "Password is invalid"
                          : null,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FlatButton(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => _loginButtonOnPressed(context),
                    minWidth: 130,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                      onTap: () => _signUpButtonOnPressed(context),
                      child: new Text("Don't have account? Sign up"),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class OuterClipperPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height / 4);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.15);
    path.quadraticBezierTo(
        size.width * 0.4, size.height * 0.3, 0, size.height * 0.2);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class InnerClipperPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.7, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.25);
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.11, size.width * 0.4, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
