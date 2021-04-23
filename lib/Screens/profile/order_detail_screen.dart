import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:grillhouse/Utils/config.dart';
import 'package:grillhouse/Utils/food_info.dart';
import 'package:grillhouse/models/ModelProvider.dart';
class OrderDetailScreen extends StatefulWidget {
  final Order order;
  final List<Food> foodList;
  final List<FoodMenuItem> foodMenu;
  OrderDetailScreen({this.order, this.foodList, this.foodMenu});
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

  List<FoodItem> localFoodList = mainFoodList;
  var dateFormat = DateFormat('d/M/y H:m:s');
  String getImage(String foodName){
    int index = localFoodList.indexWhere((element) => element.foodName == foodName);
    String image = localFoodList.elementAt(index).foodImage;
    return image;
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 30),
          child: Column(
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
              Text("Order Detail", textAlign: TextAlign.center,style: TextStyle(fontSize: 34)),

              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order on",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87)),
                  Text(dateFormat.format(DateTime.parse(widget.order.dayeTime)) ,
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
                  Text("Order Status",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87)),
                  Text(widget.order.status,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87))
                ],
              ),
              SizedBox(height: 30),
              Divider(height: 2, thickness: 1, ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Bill",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87)),
                  Text('\u20B9' + widget.order.totalAmount,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87))
                ],
              ),
              SizedBox(height: 30),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: widget.foodList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                      var foodMenuItemID = widget.foodList[index].foodMenuItemID;
                      String foodQnt = widget.foodList[index].food_quantity;
                      String foodName="", foodPrice="", foodImage="";
                      for(int i=0; i<widget.foodMenu.length; i++){
                        if(widget.foodMenu[i].id == foodMenuItemID){
                          foodName = widget.foodMenu[i].food_name;
                          foodPrice = widget.foodMenu[i].food_price;
                          foodImage = getImage(foodName);
                          break;
                        }
                      }
                      return Container(
                        margin: EdgeInsets.only(bottom: 25),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Image.asset(
                                  foodImage,
                                  height: 140,
                                  width: 130,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      foodName,
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87)
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '\u20B9' + foodPrice,
                                            style: TextStyle(
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black87)
                                        ),
                                        Text(
                                          "Qty: " + foodQnt,
                                        ),
                                      ],
                                    ),


                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      );
                  }
                  )

            ],
          )
        ),
      )
    );
  }

}
