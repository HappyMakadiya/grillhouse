import 'package:flutter/material.dart';
import 'package:grillhouse/Screens/food_detail_screen.dart';
import 'package:grillhouse/Utils/food_info.dart';

Color primaryGreen = Color(0xff416d6d);
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 5))
];

List<FoodItem> mainFoodList = [
  FoodItem(
      foodId: 0,
      foodName: "Burger",
      foodPrice: 150,
      foodImage: 'assets/images/burger.png',
      foodDetail:
          "For the cheesiest burger around , try these moreish raclette burgers."),
  FoodItem(
      foodId: 1,
      foodName: "Pizza",
      foodPrice: 300,
      foodImage: 'assets/images/pizza.png',
      foodDetail:
          "Fresh cut vegetables with thick cheese. Take the smell of spicy pepperoni and feel to have a crispy juicy crust in your hands."),
  FoodItem(
      foodId: 2,
      foodName: "French Fries",
      foodPrice: 150,
      foodImage: 'assets/images/french_fries.png',
      foodDetail: "Original Oilless crispy French Fries with tomato ketchup"),
  FoodItem(
      foodId: 3,
      foodName: "Salad",
      foodPrice: 80,
      foodImage: 'assets/images/salad.png',
      foodDetail:
          "Fresh green vegges, try some healthy with some taste of spices."),
  FoodItem(
      foodId: 4,
      foodName: "PopCorn",
      foodPrice: 80,
      foodImage: 'assets/images/popcorn.png',
      foodDetail: "Testy Salted/ buttered Popcorn"),
  FoodItem(
      foodId: 5,
      foodName: "Coffee",
      foodPrice: 100,
      foodImage: 'assets/images/coffee.png',
      foodDetail:
          "Fair trade organic coffee, with a smooth and delicate flavour"),
  FoodItem(
      foodId: 6,
      foodName: "Cola",
      foodPrice: 60,
      foodImage: 'assets/images/cola.png',
      foodDetail: "Taste the Feeling and feel Refresh")
];
