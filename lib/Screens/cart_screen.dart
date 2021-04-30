import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grillhouse/Screens/cart_model.dart';
import 'package:grillhouse/Utils/food_info.dart';
import 'package:grillhouse/models/ModelProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Razorpay razorpay;
  var userName = "";
  var userEmail = "";
  var userID = "";
  bool paymentSuccess = false;
  @override
  void initState() {
    super.initState();
    getData();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName');
      userEmail = prefs.getString('userEmail');
      userID = prefs.getString('userID');
    });
  }

  Future<dynamic> uploadData(List<FoodItem> cart, double totalAmount) async {
    DateTime dt = DateTime.now();
    String dtStr = dt.toString();
    List<Order> orderList = [];
    List<Food> foodList = [];
    User user = (await Amplify.DataStore.query(User.classType,
        where: User.EMAIL.eq(userEmail)))[0];

    Order newOrder = Order(
        user: user, userID: user.id, dayeTime: dtStr, status: "Remaining");
    await Amplify.DataStore.save(newOrder);

    Order order = (await Amplify.DataStore.query(Order.classType,
        where: Order.DAYETIME.eq(dtStr)))[0];

    for (int i = 0; i < cart.length; i++) {
      FoodMenuItem foodItem = (await Amplify.DataStore.query(
          FoodMenuItem.classType,
          where: FoodMenuItem.FOOD_NAME.eq(cart[i].foodName)))[0];
      Food food = Food(
        order: order,
        orderID: order.id,
        foodMenuItemID: foodItem.getId(),
        food_quantity: cart[i].foodQuantity.toString(),
        total_price:
            (cart[i].foodQuantity * int.parse(foodItem.food_price)).toString(),
      );
      foodList.add(food);
      await Amplify.DataStore.save(food);
    }

    Order order2 = order.copyWith(
        id: order.id,
        cart: foodList,
        totalAmount: totalAmount.toString(),
        status: "Done");
    orderList.add(order2);
    await Amplify.DataStore.save(order2);

    User newUser = user.copyWith(id: user.id, orders: orderList);
    await Amplify.DataStore.save(newUser);
  }

  Future<dynamic> payBill(double totalAmount) async {
    var options = {
      "key": "rzp_test_BkI578KkkReigI",
      "amount": (totalAmount) * 100,
      "name": "",
      "description": "",
      "external": {
        "wallets": ["paytm"],
      }
    };
    try {
      await razorpay.open(options);
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "Payment Success");
    setState(() {
      paymentSuccess = true;
    });
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment Failed");
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "External Wallet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Consumer<CartModel>(
          builder: (context, cartModel, child) => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30),
                Center(
                  child: Text(
                    "Food Cart",
                    style: TextStyle(
                      fontSize: 32,
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
                              margin: EdgeInsets.only(left: 130),
                              padding: EdgeInsets.all(25),
                              height: 140,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(cartModel.cart[index].foodName,
                                      style: TextStyle(
                                        fontSize: 24,
                                      )),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        // crossAxisAlignment: CrossAxisAlignment.baseline,
                                        children: [
                                          Text(
                                            '\u20B9',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 22,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            cartModel.cart[index].foodPrice
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(8, 5, 8, 5),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                cartModel.decreaseFood(
                                                    cartModel.cart[index]);
                                              },
                                              child: Icon(CupertinoIcons.minus,
                                                  color: Colors.white),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                              child: Text(
                                                cartModel
                                                    .cart[index].foodQuantity
                                                    .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                cartModel.addFood(
                                                    cartModel.cart[index]);
                                              },
                                              child: Icon(
                                                CupertinoIcons.add,
                                                color: Colors.white,
                                              ),
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
                ),
                cartModel.totalCartValue == 0
                    ? Container(
                        child: Center(
                            child: Column(
                          children: [
                            Image.asset('assets/images/empty_cart.png',
                                width: 100, height: 100),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Ohh...Cart is Empty",
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xffff4141)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Add Something to make me happy :)",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        )),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Amount",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87)),
                            Text('\u20B9' + cartModel.totalCartValue.toString(),
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87)),
                          ],
                        ),
                      ),
                ButtonTheme(
                  height: 50,
                  textTheme: ButtonTextTheme.primary,
                  buttonColor: Theme.of(context).primaryColor,
                  child: cartModel.totalCartValue == 0
                      ? Container()
                      : Container(
                          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                          child: RaisedButton(
                            onPressed: () async {
                              await payBill(cartModel.totalCartValue);
                              if (paymentSuccess == true) {
                                await uploadData(
                                    cartModel.cart, cartModel.totalCartValue);
                                await cartModel.clearCart();
                                paymentSuccess = false;
                                Navigator.of(context)
                                    .pushReplacementNamed("/getcode_screen");
                              } else {
                                await cartModel.clearCart();
                                paymentSuccess = false;

                                Navigator.of(context)
                                    .pushReplacementNamed("/navbar");
                              }
                            },
                            child: Text("Pay & Order",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
