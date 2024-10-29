import 'package:cafe_lp/pages/models/food.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier {
  final List<Food> _foodMenu = [
    //cappuchino
    Food(
        name: "Cappuchino",
        price: "Rs. 190",
        imagepath: "assets/images/unsplash_wd_j_5_txrg_7_k_1.jpeg",
        rating: "4.3"),

    //espresso
    Food(
        name: "Espresso",
        price: "Rs. 150",
        imagepath: "assets/images/espresso.jpg",
        rating: "4.7"),

    //iced mocha
    Food(
        name: "Iced Mocha",
        price: "Rs. 230",
        imagepath: "assets/images/unsplashv_zozjh_xk_uk_1.jpeg",
        rating: "4.3"),

    //avocado toast
    Food(
        name: "Avocado Toast",
        price: "Rs. 250",
        imagepath: "assets/images/avocadotoast.jpg",
        rating: "4.2"),

    //chocolate croissant
    Food(
        name: "Chocolate Croissant",
        price: "Rs. 160",
        imagepath: "assets/images/chocolatecroissant.jpg",
        rating: "4.6"),

    //blueberry muffin
    Food(
        name: "Blueberry Muffin",
        price: "Rs. 130",
        imagepath: "assets/images/blueberrymuffin.jpg",
        rating: "4.3"),

    //burrito bowl
    Food(
        name: "Burrito Bowl",
        price: "Rs. 280",
        imagepath: "assets/images/burritobowl.jpg",
        rating: "4.5"),

    //acai bowl
    Food(
        name: "Acai Bowl",
        price: "Rs. 200",
        imagepath: "assets/images/acaibowl.jpg",
        rating: "4.6"),
  ];

  //customers cart
  List<Food> _cart = [];

  // getter methods
  List<Food> get foodMenu => _foodMenu;
  List<Food> get cart => _cart;

  //add to cart
  void addToCart(Food foodItem, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(foodItem);
    }
    notifyListeners();
  }

  //remove from cart
  void removeFromCart(Food food) {
    _cart.remove(food);
    notifyListeners();
  }
}
