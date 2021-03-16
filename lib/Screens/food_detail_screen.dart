import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grillhouse/Screens/cart_model.dart';
import 'package:grillhouse/Utils/config.dart';
import 'package:grillhouse/Utils/food_info.dart';
import 'package:provider/provider.dart';

class FoodDetail extends StatefulWidget {
  int index;
  FoodDetail(this.index);
  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  Food food;
  int quantity=0;
  @override
  void initState() {
    super.initState();
    food = mainFoodList.elementAt(widget.index);
  }


  @override
  Widget build(BuildContext context) {
    var srcWidth = MediaQuery.of(context).size.width;
    return Consumer<CartModel>(
      builder: (context, cartModel, child) => Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: food.foodQuantity == 0 ? (){
            cartModel.addFood(food);
          }: null,
          icon: food.foodQuantity == 0 ? Icon(CupertinoIcons.bag_badge_plus): null,
          label: food.foodQuantity == 0 ? Text("Add to Cart") : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                  cartModel.decreaseFood(food);
                },
                child: Icon(CupertinoIcons.minus, color: Colors.white,),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,0,10,0),
                child: Text(
                  food.foodQuantity.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white,),
                ),
              ),
              InkWell(
                onTap: (){
                  cartModel.addFood(food);
                },
                child: Icon(CupertinoIcons.add, color: Colors.white,),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child:Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
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
                      CircleAvatar(
                        child: Icon(
                          CupertinoIcons.heart,
                          size: 26,
                          color: Colors.black54,
                        ),
                        backgroundColor: Colors.white,
                        radius: 26,
                      )
                    ],
                  ),
                ),
                Container(
                  child: Image.asset(
                    food.foodImage,
                    width: 280,
                    height: 280,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 26),
                  padding: EdgeInsets.fromLTRB(40,20,40,20),
                  height: 350,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            food.foodName,
                            style: TextStyle(
                              fontSize: 36
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Text(
                                  '\u20B9',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 34,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  food.foodPrice.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 34,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Text(
                        "Details",
                        style: TextStyle(
                            fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "jdhsgfhd shdgf jsdhgfj hdgsf shfgdsfhjs dshfjsd jdshfj jhsd ghgfhsdgf hsdfgjhs df",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
