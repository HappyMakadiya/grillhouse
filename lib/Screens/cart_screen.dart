import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grillhouse/Screens/cart_model.dart';
import 'package:grillhouse/Utils/config.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Consumer<CartModel>(
            builder: (context, cartModel, child) => Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Center(
                    child: Text(
                      "Food Cart",
                      style: TextStyle(
                        fontSize: 30
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: cartModel.cart.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: 'Delete',
                              color: Colors.red,
                              icon: CupertinoIcons.delete,
                              onTap: () {
                                cartModel.removeFood(cartModel.cart[index]);
                              },
                            ),
                          ],
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left:130),
                                padding: EdgeInsets.all(25),
                                height: 140,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      cartModel.cart[index].foodName,
                                      style: TextStyle(
                                        fontSize: 24,
                                      )
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.baseline,
                                          children: [
                                            Text(
                                              '\u20B9',
                                              style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: 22,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              cartModel.cart[index].foodPrice.toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),

                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(8,5,8,5),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColor,
                                              borderRadius: BorderRadius.circular(20)
                                          ),

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  cartModel.decreaseFood(cartModel.cart[index]);
                                                },
                                                child: Icon(CupertinoIcons.minus, color: Colors.white),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(10,0,10,0),
                                                child: Text(
                                                  cartModel.cart[index].foodQuantity.toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white,),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  cartModel.addFood(cartModel.cart[index]);
                                                },
                                                child: Icon(CupertinoIcons.add, color: Colors.white,),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    cartModel.cart[index].foodImage,
                                    height: 140,
                                    width: 130,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );

                    },
                  )

                ],
              ),
            ),
          ),
      ),
    );
  }
}
