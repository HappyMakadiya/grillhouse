import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grillhouse/Screens/cart_model.dart';
import 'package:grillhouse/Utils/sentiment.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatefulWidget {
  ReviewScreen({Key key}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final _formKey = GlobalKey<FormState>();

  final reviewTextController = TextEditingController();
  Future<Sentiment> sentiment;

  Future<Sentiment> fetchData(String reviewMsg) async {
    var queryPara = {'review': reviewMsg};
    final response = await get(Uri.https(
        's5zfrm0sr0.execute-api.ap-south-1.amazonaws.com',
        '/test',
        queryPara));

    if (response.statusCode == 200) {
      return Sentiment.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Container(
        color: Color(0xffeae9e9),
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Give Food Review",
                style: TextStyle(
                  fontSize: 30
                )
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: reviewTextController,
                decoration: InputDecoration(
                  focusColor: Colors.blueGrey,
                  hintText: "Enter Your Review",
                  suffixIcon: Icon(
                    Icons.navigate_next_rounded
                  ) ,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  border: OutlineInputBorder(),
                  labelText: 'Review',
                ),
                onChanged: (value){
                  setState(() {
                    if(reviewTextController.text.isEmpty == null ){
                      sentiment = null;
                    }else{
                      sentiment = fetchData(reviewTextController.text);
                    }
                  });
                },
                validator: (value) => reviewTextController.text.isEmpty
                    ? "Enter Your Review"
                    : null,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 100,
              ),
              sentiment == null
                  ? SizedBox()
                  : FutureBuilder<Sentiment>(
                      future: sentiment,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(
                                color: snapshot.data.sentiment == "POSITIVE"
                                    ? Colors.green[400]
                                    : snapshot.data.sentiment == "NEGATIVE"
                                        ? Colors.red[400]
                                        : snapshot.data.sentiment == "NEUTRAL"
                                            ? Colors.yellow[800]
                                            : Colors.brown[400],
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "You Have Given " +
                                  snapshot.data.sentiment +
                                  " Review.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return CircularProgressIndicator();
                      }),
              SizedBox(
                height: 100,
              ),
              // ButtonTheme(
              //   height: 50,
              //   textTheme: ButtonTextTheme.primary,
              //   buttonColor: Theme.of(context).primaryColor,
              //   child: Container(
              //     margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
              //     child: RaisedButton(
              //       onPressed: () async {
              //         Navigator.of(context).pushReplacementNamed("/navbar");
              //       },
              //       child: Text("Submit Your Review",
              //           style: TextStyle(color: Colors.white)),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    )));
  }
}
