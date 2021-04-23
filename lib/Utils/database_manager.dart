import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DatabaseManager{
  String name,email,uid;
  UserData userData;

  Future<void> uploadUserData(String name, String email, String uid) async {
    return await userlist.doc(uid).set({
      'name': name,
      'email': email // 42
    }).then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  Future<void> uploadOrderData(List<Product> products, String uid, double totalAmount, Map address) async {
    DateTime dt = DateTime.now();
    orderlist.doc(uid).collection(dt.toUtc().toString()).doc("TotalAmount").set({
      "total_amount": totalAmount
    });
    orderlist.doc(uid).collection(dt.toUtc().toString()).doc("Address").set({
      "address": address
    });
    for(int i=0; i<products.length; i++){
      await orderlist.doc(uid).collection(dt.toUtc().toString()).doc( "P"+i.toString()).set({
            "productID": products[i].productId,
            "productName": products[i].productName,
            "productQuantity": products[i].productQuantity,
            "productPrice": products[i].productPrice,
      });
    }
  }
  Future getUserData(String uid) async{
    try{
      DocumentSnapshot snapshot = await userlist.doc(uid).get();
        if (snapshot.exists) {
          name = snapshot['name'];
          email = snapshot['email'];
          userData = UserData(username: name, useremail: email);
        }
      return userData;
    } catch(e){
      print(e);
    }

  }
}