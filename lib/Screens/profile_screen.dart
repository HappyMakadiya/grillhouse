import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: CupertinoButton.filled(
        onPressed: () async {
          await Amplify.Auth.signOut();
          Navigator.of(context).pushReplacementNamed('/login_screen');
        },
        child: Text("Sign Out"),
      ),
    );
  }
}
