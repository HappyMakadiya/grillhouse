import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'file:///D:/Happy/6.sem-6/18IT055/SGP/grillhouse/lib/Screens/Registration/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthUser _user;
  var res;
  String name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Amplify.Auth.getCurrentUser().then((user) {
      setState(() {
        _user = user;
      });
    }).catchError((e) {
      print((e as AuthException).message);
    });
  }
  void fetchUserData() async{
    var res = await Amplify.Auth.fetchUserAttributes();
    var index = res.indexWhere((element) => element.userAttributeKey == 'name');
    AuthUserAttribute nameAttribute = res.elementAt(index);
    setState(() {
      name = nameAttribute.value;
    });

  }
  @override
  Widget build(BuildContext context) {
    fetchUserData();
        return Scaffold(
          appBar: AppBar(
            title: Text("Main screen"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("AWS Amplify"),
                Text("Name $name"),
                Text("User ID ${_user?.userId}"),
                Text("User Name ${_user?.username}"),
                FlatButton(
                  onPressed: () async {
                    try {
                      await Amplify.Auth.signOut().whenComplete(() =>  Navigator.pushReplacementNamed(context, '/login_screen'));
                      print("sign out");
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text("Sign Out"),
                )
              ],
            ),
          ),
        );
  }
}
