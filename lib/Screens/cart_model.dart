import 'package:flutter/cupertino.dart';
import 'package:grillhouse/Utils/food_info.dart';

class CartModel with ChangeNotifier{
  List<Food> cart = [];
  double totalCartValue = 0;

  int get total => cart.length;

  void addFood(Food food) {
    int index = cart.indexWhere((i) => i.foodId == food.foodId);
    if (index != -1)
      updateFood(food, food.foodQuantity + 1);
    else {
      cart.add(food);
      updateFood(food, food.foodQuantity + 1);
      calculateTotal();
      notifyListeners();
    }
  }

  void decreaseFood(Food food) {
    int index = cart.indexWhere((i) => i.foodId == food.foodId);
    if (index != -1){
      if(cart[index].foodQuantity > 0 ){
        updateFood(food, food.foodQuantity - 1);
      }
    }
    calculateTotal();
    notifyListeners();
  }

  void removeFood(Food food) {
    int index = cart.indexWhere((i) => i.foodId == food.foodId);
    cart[index].foodQuantity = 0;
    cart.removeWhere((item) => item.foodId == food.foodId);
    calculateTotal();
    notifyListeners();
  }

  void updateFood(Food food, qty) {
    int index = cart.indexWhere((i) => i.foodId == food.foodId);
    cart[index].foodQuantity = qty;
    if (cart[index].foodQuantity == 0)
      removeFood(food);

    calculateTotal();
    notifyListeners();
  }

  void clearCart() {
    cart.forEach((f) => f.foodQuantity = 0);
    cart = [];
    notifyListeners();
  }

  void calculateTotal() {
    totalCartValue = 0;
    cart.forEach((f) {
      totalCartValue += f.foodPrice * f.foodQuantity;
    });
  }

}