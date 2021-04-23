import 'dart:ui';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:grillhouse/Screens/Registration/login_screen.dart';
import 'package:grillhouse/Screens/cart_model.dart';
import 'package:grillhouse/Screens/navbar.dart';
import 'package:grillhouse/Utils/route_generator.dart';
import 'package:grillhouse/models/ModelProvider.dart';
import 'package:grillhouse/models/Todo.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
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
  bool isAmplifyConfigured = false;
  @override
  initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      Amplify.addPlugins([
        AmplifyAuthCognito(),
        AmplifyAPI(),
        AmplifyDataStore(modelProvider: ModelProvider.instance)
      ]);
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException catch (_) {
      print("Amplify Alerady Configure");
    } on AmplifyException catch (_) {
      print("Amplify Exception");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartModel>(
          create: (_) => CartModel(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Open Sans',
          primaryColor: Color(0xffffb525),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

class CheckUserState extends StatefulWidget {
  @override
  _CheckUserStateState createState() => _CheckUserStateState();
}

class _CheckUserStateState extends State<CheckUserState> {
  ProgressDialog pr;
  bool isUserSignedIn = false;
  @override
  void initState() {
    super.initState();


    checkUserSignedIn();
  }

  Future<void> checkUserSignedIn() async {
    try {
      CognitoAuthSession res = await Amplify.Auth.fetchAuthSession();
      setState(() {
        isUserSignedIn = res.isSignedIn;
      });

      print(isUserSignedIn);
    } on AuthException catch (e) {
      print(e.message);
    }
    if (isUserSignedIn) {
      Navigator.of(context).pushReplacementNamed('/navbar');
    } else {
      Navigator.of(context).pushReplacementNamed('/login_screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(
          radius: 40,
        ),
      ),
    );
  }
}
