import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grillhouse/Screens/user_info.dart';
import 'package:grillhouse/models/ModelProvider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'email_verification_screen.dart';
import '../../Utils/email_validator.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  UserInfoData _userInfo;
  bool _isHiddenP = true;
  bool _isHiddenCP = true;

  Future<void> _createAccountOnPressed(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal);
      pr.style(progressWidget: CupertinoActivityIndicator());

      final email = _emailController.text;
      final password = _passwordController.text;
      final name = _nameController.text;
      _userInfo = UserInfoData(email: email, password: password, name: name);
      await pr.show();
      try {
        var signupResult = await Amplify.Auth.signUp(
            username: email,
            password: password,
            options: CognitoSignUpOptions(userAttributes: {'email': email, 'name':name}));
        if (signupResult.isSignUpComplete) {
          await pr.hide();
          Navigator.of(context).pushNamed('/verify_email', arguments: _userInfo );
        }
      } on UsernameExistsException catch (e) {
        await pr.hide();
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("User Already Exist! Try another email address."),
          ),

        );
      } on AuthException catch(e){
        await pr.hide();
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("Something Went Wrong! Try again later."),
          ),
        );
      }
    }
  }

  void _loginButtonOnPressed(BuildContext context)  {
    Navigator.of(context).pushNamed("/login_screen");
  }

  void _togglePasswordView() {
    setState(() {
      _isHiddenP = !_isHiddenP;
    });
  }

  void _toggleConfirmPasswordView() {
    setState(() {
      _isHiddenCP = !_isHiddenCP;
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
          physics: ClampingScrollPhysics(),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 220),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Create New Account',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Open Sans',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      cursorColor: Theme.of(context).primaryColor,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        labelText: "Name",
                        border: OutlineInputBorder(),
                      ),
                      controller: _nameController,
                      validator: (value) =>
                      value.isEmpty ? "Enter Your Name" : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Theme.of(context).primaryColor,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                      obscureText: _isHiddenP,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(),
                        labelText: 'New Password',
                        suffix: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            _isHiddenP
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      controller: _passwordController,
                      validator: (value) => value.length < 8
                          ? "Password must be atleast 8 letter long"
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: TextFormField(
                      obscureText: _isHiddenCP,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        suffix: InkWell(
                          onTap: _toggleConfirmPasswordView,
                          child: Icon(
                            _isHiddenCP
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      controller: _confirmPasswordController,
                      validator: (value) => value != _passwordController.text
                          ? "Password doesn't match"
                          : null,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  FlatButton(
                    child: Text(
                      "Signup",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => _createAccountOnPressed(context),
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
                      onTap: () => _loginButtonOnPressed(context),
                      child: new Text("Already have account? Login"),
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
