import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:grillhouse/Screens/food_detail_screen.dart';
import 'package:grillhouse/Utils/config.dart';
import 'package:grillhouse/Utils/food_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String userName = " ";
  List<FoodItem> foodList = mainFoodList;

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 0;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName');
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi there!",
                          style: TextStyle(fontSize: 22, color: Colors.black54),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          userName,
                          style: TextStyle(fontSize: 26, color: Colors.black87),
                        )
                        // StreamBuilder<List<AuthUserAttribute>>(
                        //     stream:
                        //         Amplify.Auth.fetchUserAttributes().asStream(),
                        //     builder: (BuildContext context,
                        //         AsyncSnapshot<List<AuthUserAttribute>>
                        //             snapshot) {
                        //       if (snapshot.hasError) {
                        //         return Text('Error: ${snapshot.error}');
                        //       } else if (snapshot.hasData) {
                        //         var index = snapshot.data.indexWhere(
                        //             (element) => element.userAttributeKey == 'name');
                        //         var nameAttribute = snapshot.data.elementAt(index);
                        //         return Text(
                        //           nameAttribute.value,
                        //           style: TextStyle(
                        //               fontSize: 26, color: Colors.black87),
                        //         );
                        //       }
                        //       return CircularProgressIndicator();
                        //     }),
                      ],
                    ),
                    CircleAvatar(
                      child: Image.asset(
                        'assets/images/avatar1.png',
                        height: 100,
                      ),
                      radius: 30,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 20)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Search..",
                      prefixIcon: Icon(CupertinoIcons.search),
                      floatingLabelBehavior: FloatingLabelBehavior.always),
                  cursorColor: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                child: GridView.count(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2.5,
                    physics: PageScrollPhysics(),
                    children: List.generate(foodList.length, (index) {
                      return Container(
                        margin: EdgeInsets.all(10),
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
                                    margin: EdgeInsets.only(top: 40),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(height: 50),
                                        Text(
                                          foodList[index].foodName,
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          '\u20B9' +
                                              foodList[index]
                                                  .foodPrice
                                                  .toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FoodDetailScreen(index)),
                                                );
                                              },
                                              child: Icon(
                                                  Icons.navigate_next_rounded,
                                                  size: 40,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Image.asset(
                                      foodList[index].foodImage,
                                      height: 100,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
              ),
            ],
          )),
        ));
  }
}
