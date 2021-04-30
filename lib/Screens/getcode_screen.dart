import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class GetCodeScreen extends StatefulWidget {
  GetCodeScreen({Key key}) : super(key: key);

  @override
  _GetCodeScreenState createState() => _GetCodeScreenState();
}

class _GetCodeScreenState extends State<GetCodeScreen> {
  int code = 0;
  String strCode = "C-";

  @override
  void initState() {
    super.initState();
    int nextInt(int min, int max) => min + Random().nextInt((max + 1) - min);
    code = nextInt(100, 900);
    strCode = "C-" + code.toString();
    storeData();
    setState(() {});
  }

  Future<void> storeData()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('orderCode', strCode);
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Order Code",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 34)),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Text(
                            "Your Food order code is given below. Collect your order When this code display on the screen.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 16)),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Text(strCode,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 34)),
                      SizedBox(
                        height: 80,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: FlatButton(
                          child: Text(
                            "Exit",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed("/navbar");
                          },
                          minWidth: 50,
                          height: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ]))));
  }
}
