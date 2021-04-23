import 'dart:developer';
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
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'amplifyconfiguration.dart';
import 'package:grillhouse/models/ModelProvider.dart';

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
  initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    await Amplify.addPlugin(AmplifyAuthCognito());
    await Amplify.addPlugin(AmplifyAPI());
    await Amplify.addPlugin(AmplifyDataStore(modelProvider: ModelProvider.instance));

    try{
      await Amplify.configure(amplifyconfig);
    }on AmplifyException catch(e){
    }catch(e){
      print(e);
    }
    final item = Todo(name: "test", id: "1", description:"Text");
    await Amplify.DataStore.save(item);

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
  @override
  void initState() {
    super.initState();
    pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(progressWidget: CupertinoActivityIndicator());
    pr.show();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthUser>(
      stream: Amplify.Auth.getCurrentUser().asStream(),
      builder: (BuildContext context, AsyncSnapshot<AuthUser> snapshot) {
        if (snapshot.data == null) {
          pr.hide();
          return LoginScreen();
        } else if (snapshot.data != null) {
          pr.hide();
          return NavBar();
        } else {
          pr.hide();
          return Text('Error: ${snapshot.error}');
        }
      },
    );
  }
}
