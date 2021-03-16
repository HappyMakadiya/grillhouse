import 'package:flutter/material.dart';
import 'package:grillhouse/Utils/food_info.dart';

Color primaryGreen = Color(0xff416d6d);
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 5))
];

List<Food> mainFoodList = [
    Food(
      foodId: 0,
      foodName: "Burger",
      foodPrice: 220,
      foodImage: 'assets/images/burger.png',
    ),
    Food(
        foodId: 1,
        foodName: "Pizza",
        foodPrice: 300,
        foodImage: 'assets/images/pizza.png'
    ),
    Food(
        foodId: 2,
        foodName: "French Fries",
        foodPrice: 150,
        foodImage: 'assets/images/french_fries.png'
    ),
    Food(
        foodId: 3,
        foodName: "Salad",
        foodPrice: 100,
        foodImage: 'assets/images/salad.png'
    ),
    Food(
        foodId: 4,
        foodName: "PopCorn",
        foodPrice: 80,
        foodImage: 'assets/images/popcorn.png'
    ),
    Food(
        foodId: 5,
        foodName: "Coffee",
        foodPrice: 100,
        foodImage: 'assets/images/coffee.png'
    ),
    Food(
        foodId: 6,
        foodName: "Cola",
        foodPrice: 70,
        foodImage: 'assets/images/cola.png'
    )

];
