import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:grillhouse/Screens/mydrawer.dart';
import 'package:grillhouse/Utils/config.dart';
import 'package:grillhouse/Utils/food_info.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AuthUser _user;
  var res;
  String name;
  List<Food> foodList = mainfoodList;

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 0;
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

  void fetchUserData(BuildContext context) async {
    var res = await Amplify.Auth.fetchUserAttributes();
    var index = res.indexWhere((element) => element.userAttributeKey == 'name');
    AuthUserAttribute nameAttribute = res.elementAt(index);
    setState(() {
      name = nameAttribute.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    fetchUserData(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => _scaffoldKey.currentState.openDrawer(),
                  child: Icon(
                    CupertinoIcons.bars,
                    size: 30,
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Icon(
                    CupertinoIcons.bag,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: MyDrawer(),

        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 30, 30),
                    child: Text(
                      "Food For You",
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Container(
                    child: GridView.count(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 2/2.8,
                        physics: PageScrollPhysics(),
                        children: List.generate(foodList.length, (index) {
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: shadowList,
                                        ),
                                        margin: EdgeInsets.only(top: 40, bottom: 30),
                                      ),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              foodList[index].foodImage,
                                              height: 100,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              foodList[index].foodName,
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              '\u20B9'+foodList[index].foodPrice.toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            SizedBox(height: 20),
                                            CircleAvatar(
                                              child: Icon(Icons.navigate_next_rounded,size: 20, color: Colors.white),
                                              backgroundColor: Theme.of(context).primaryColor,
                                              radius: 20,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                            );
                        })),
                  ),
                ],
              )),
        ));
  }
}
