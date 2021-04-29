import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var userName = "";
  var userEmail = "";
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName');
      userEmail = prefs.getString('userEmail');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                    padding: EdgeInsets.fromLTRB(30, 40, 30, 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },

                              child: CircleAvatar(
                                child: Icon(
                                  CupertinoIcons.back,
                                  size: 26,
                                  color: Colors.black54,
                                ),
                                backgroundColor: Colors.white,
                                radius: 26,
                              ),
                            ),
                          ),
                          Text("Account", textAlign: TextAlign.center,style: TextStyle(fontSize: 34)),
                          SizedBox(
                            height: 40,
                          ),
                          Text("Name"),


                        ]
                    )
                )
            )
        )
    );
  }
}
