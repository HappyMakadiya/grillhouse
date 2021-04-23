import 'dart:ui';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:grillhouse/Screens/Registration/login_screen.dart';
import 'amplifyconfiguration.dart';
import 'package:grillhouse/models/ModelProvider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState(){
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {

    await Amplify.addPlugin(AmplifyDataStore(modelProvider: ModelProvider.instance));
    await Amplify.addPlugin(AmplifyAuthCognito());
    await Amplify.addPlugin(AmplifyAPI());
    try {
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      print("MyAmplifyException" + e.message);
    }
    final item = Todo(name: "test", description: "desc");
    await Amplify.DataStore.save(item);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xffffb525),
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen()
    );
  }
}