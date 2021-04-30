import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class OrderStatusScreen extends StatefulWidget {
  OrderStatusScreen({Key key}) : super(key: key);

  @override
  _OrderStatusScreenState createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  var strCode = "NA";

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      strCode = prefs.getString('orderCode') ?? "NA";
    });
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
                      Text(strCode == 'NA' ? "No order is Placed" : strCode,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 34)),
                      SizedBox(
                        height: 80,
                      ),
                      strCode == 'NA' ? Container() : Container(
                        margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: FlatButton(
                          child: Text(
                            "Order Taken",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.remove('orderCode');
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
