import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:grillhouse/Screens/Registration/login_screen.dart';
import 'package:grillhouse/Utils/route_generator.dart';
import 'Screens/home_screen.dart';
import 'amplifyconfiguration.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  initState()  {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
      Amplify.addPlugins([authPlugin]);
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Open Sans',
        primaryColor: Color(0xfffe724c),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class UserState extends StatefulWidget {
  @override
  _UserStateState createState() => _UserStateState();
}

class _UserStateState extends State<UserState> {

  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    await Amplify.Auth.getCurrentUser().then((value) => {
        _isLoggedIn = true
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    if(_isLoggedIn){
      return HomeScreen();
    } else{
      return LoginScreen();
    }
  }
}

