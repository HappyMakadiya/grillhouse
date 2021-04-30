import 'package:amplify_flutter/amplify.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          children: [
            Center(
              child: AutoSizeText(
                "Profile",
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Row(
                children: [
                  Container(
                    child: CircleAvatar(
                      child: Image.asset(
                        'assets/images/avatar1.png',
                        height: 200,
                      ),
                      radius: 46,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            userName,
                            maxLines: 1,
                            style: TextStyle(fontSize: 30),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AutoSizeText(
                            userEmail,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 40, 30, 40),
              padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
              // height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50))
              ),
              child: Column(
                children: [
                  // Material(
                  //   color: Colors.white,
                  //   child: InkWell(
                  //     borderRadius: BorderRadius.circular(10),
                  //     onTap: () {Navigator.of(context).pushNamed('/account_screen');},
                  //     child: Container(
                  //       padding: EdgeInsets.all(10),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           AutoSizeText(
                  //             "Account",
                  //             style: TextStyle(
                  //                 fontSize: 24, fontWeight: FontWeight.w500),
                  //           ),
                  //           Icon(
                  //             Icons.chevron_right_rounded,
                  //             size: 38,
                  //             color: Colors.grey[800],
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                   Material(
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () { Navigator.of(context).pushNamed('/order_status_screen');},
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              "Order Status",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 38,
                              color: Colors.grey[800],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () { Navigator.of(context).pushNamed('/past_order_screen');},
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              "Past Order",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 38,
                              color: Colors.grey[800],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Material(
                  //   color: Colors.white,
                  //   child: InkWell(
                  //     borderRadius: BorderRadius.circular(10),
                  //     onTap: () {},
                  //     child: Container(
                  //       padding: EdgeInsets.all(10),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           AutoSizeText(
                  //             "Your Reviews",
                  //             style: TextStyle(
                  //                 fontSize: 24, fontWeight: FontWeight.w500),
                  //           ),
                  //           Icon(
                  //             Icons.chevron_right_rounded,
                  //             size: 38,
                  //             color: Colors.grey[800],
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Material(
                  //   color: Colors.white,
                  //   child: InkWell(
                  //     borderRadius: BorderRadius.circular(10),
                  //     onTap: () {},
                  //     child: Container(
                  //       padding: EdgeInsets.all(10),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           AutoSizeText(
                  //             "Settings",
                  //             style: TextStyle(
                  //                 fontSize: 24, fontWeight: FontWeight.w500),
                  //           ),
                  //           Icon(
                  //             Icons.chevron_right_rounded,
                  //             size: 38,
                  //             color: Colors.grey[800],
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () async {
                        var prefs = await SharedPreferences.getInstance();
                        await prefs.clear();
                        await Amplify.DataStore.clear();
                        await Amplify.Auth.signOut();
                        Navigator.of(context)
                            .pushReplacementNamed('/login_screen');
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              "Sign Out",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 38,
                              color: Colors.grey[800],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
            // CupertinoButton.filled(
            //   onPressed: () async {
            //     await Amplify.Auth.signOut();
            //     Navigator.of(context).pushReplacementNamed('/login_screen');
            //   },
            //   child: AutoSizeText("Sign Out"),
            // ),
          ],
        ),
      ),
    );
  }
}
