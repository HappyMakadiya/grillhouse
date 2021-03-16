import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grillhouse/Screens/user_info.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {


  UserInfoData userInfo;
  AuthUser _user;
  var res, index;
  AuthUserAttribute nameAttribute;

  final List<String> menuItem = [
    "Home",
    "Cart",
    "Subscription",
    "User Profile",
    "Setting"
  ];
  final List<IconData> menuIcon = [
    Icons.dashboard,
    Icons.shopping_cart,
    Icons.subscriptions,
    Icons.person,
    Icons.settings
  ];

  final List<String> pageRouteList = [
    "/home_screen",
    "/cart_screen",
    "/subscription_screen",
    "/userprofile_screen",
    "/setting_screen"
  ];

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
    // fetchUserData();

  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: UserPanel(context),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20,30,20,0),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 18,
                      )
                  ),
                  onTap: (){Navigator.of(context).pushNamed('/home_screen');},
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text(
                      "Cart",
                      style: TextStyle(
                        fontSize: 18,
                      )
                  ),
                  onTap: (){Navigator.of(context).pushNamed('/cart_screen');},
                ),
                ListTile(
                  leading: Icon(Icons.subscriptions),
                  title: Text(
                      "Subscription",
                      style: TextStyle(
                        fontSize: 18,
                      )
                  ),
                  onTap: (){Navigator.of(context).pushNamed('/subscription_screen');},
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                      "User Profile",
                      style: TextStyle(
                        fontSize: 18,
                      )
                  ),
                  onTap: (){Navigator.of(context).pushNamed('/userprofile_screen');},
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 18,
                      )
                  ),
                  onTap: (){Navigator.of(context).pushNamed('/setting_screen');},
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 18,
                      )
                  ),
                  onTap: () async {
                    try {
                      await Amplify.Auth.signOut().whenComplete(() =>  Navigator.pushReplacementNamed(context, '/login_screen'));
                      print("sign out");
                    } catch (e) {
                      print(e);
                    }

                    },
                ),
              ],
            )
          )
        ],
      ),
    );
  }

  Widget UserPanel(BuildContext context) {
    return _user != null ? DrawerHeader(
      child: StreamBuilder<List<AuthUserAttribute>>(
        stream: Amplify.Auth.fetchUserAttributes().asStream(),
        builder:
            (BuildContext context, AsyncSnapshot<List<AuthUserAttribute>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            index = snapshot.data.indexWhere((element) => element.userAttributeKey == 'name');
            nameAttribute = snapshot.data.elementAt(index);

            return Container(
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.person,size: 40, color: Colors.white,),
                    backgroundColor: Colors.white30,
                    radius: 40,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nameAttribute.value,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                _user?.username,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                )
                            )
                          ]
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return LinearProgressIndicator(
             backgroundColor: Theme.of(context).primaryColor,
             minHeight: 200,
             valueColor: AlwaysStoppedAnimation<Color>(Color(0xffa32200)),
          );
        },
      ),
    ) : Center(child: CircularProgressIndicator(),);
  }


}

