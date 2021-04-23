import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:grillhouse/models/ModelProvider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:grillhouse/Screens/profile/order_detail_screen.dart';

class PastOrderScreen extends StatefulWidget {
  PastOrderScreen({Key key}) : super(key: key);

  @override
  _PastOrderScreenState createState() => _PastOrderScreenState();
}

class _PastOrderScreenState extends State<PastOrderScreen> {
  var userEmail = "";
  bool loading = true;
  List<Order> orderList = [];
  var dateFormat = DateFormat('d/M/y H:m:s');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    getData();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString('userEmail');
    User user = (await Amplify.DataStore.query(User.classType,
        where: User.EMAIL.eq(userEmail)))[0];

    orderList = await Amplify.DataStore.query(Order.classType,
        where: Order.USERID.eq(user.id).and(Order.STATUS.eq("Done")));
    setState(() {  loading = false;});

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: loading
              ? Center(child: CupertinoActivityIndicator(
                  radius: 20,
                ))
              : orderList.isEmpty
              ? Center(child: Text("No Order", style: TextStyle(fontSize: 20)))
              : SingleChildScrollView(
            physics: BouncingScrollPhysics(),
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 40, 20, 30),
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
                        Text("Orders", textAlign: TextAlign.center,style: TextStyle(fontSize: 34)),
                        SizedBox(
                          height: 40,
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: orderList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 25),
                                padding: EdgeInsets.all(20),
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),

                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Order on",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black87)),
                                        Text(dateFormat.format(DateTime.parse(orderList[index].dayeTime)) ,
                                            style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87))
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Status",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black87)),
                                        Text(orderList[index].status,
                                            style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87))
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Divider(height: 2, thickness: 1, ),

                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('\u20B9 ${orderList[index].totalAmount}',
                                            style: TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black87)
                                        ),
                                        ButtonTheme(
                                          height: 40,

                                          textTheme: ButtonTextTheme.primary,
                                          buttonColor: Theme.of(context).primaryColor,
                                          child: Container(
                                            child: RaisedButton(
                                              onPressed: () async {
                                                List<FoodMenuItem> foodMenu = await Amplify.DataStore.query(FoodMenuItem.classType);
                                                List<Food> foodList = await Amplify.DataStore.query(Food.classType, where: Food.ORDERID.eq(orderList[index].id));
                                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderDetailScreen(order: orderList[index], foodList: foodList, foodMenu: foodMenu)));
                                              },
                                              child: Text("View Detail",
                                                  style: TextStyle(color: Colors.white)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              );
                            })
                      ],
                    )),
              )),
    );
  }
}
