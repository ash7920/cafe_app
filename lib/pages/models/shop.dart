import 'dart:convert';
import 'package:cafe_lp/pages/models/food.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Shop extends ChangeNotifier {
  List<Food> _foodMenu = [];
  final Map<Food, int> _cart = {}; // Updated: Use a Map for cart to track quantities.

  // Getter methods
  List<Food> get foodMenu => _foodMenu;
  Map<Food, int> get cart => _cart;

  Shop() {
    fetchFoodMenu();
  }

  Future<void> fetchFoodMenu() async {
    final url = Uri.parse('https://unicode-flutter-lp-new-final.onrender.com/get_all_products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        _foodMenu = decodedData.map((item) => Food.fromJson(item)).toList();
        notifyListeners();
      } else {
        // Handle error
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Error fetching data: $e');
    }
  }

  // Add to cart
  void addToCart(Food foodItem, int quantity) {
    if (_cart.containsKey(foodItem)) {
      _cart[foodItem] = (_cart[foodItem]! + quantity);
    } else {
      _cart[foodItem] = quantity;
    }
    notifyListeners();
  }

  // Remove one from cart
  void removeOneFromCart(Food foodItem) {
    if (_cart.containsKey(foodItem)) {
      if (_cart[foodItem]! > 1) {
        _cart[foodItem] = _cart[foodItem]! - 1;
      } else {
        _cart.remove(foodItem); // Remove completely if quantity becomes zero
      }
    }
    notifyListeners();
  }

  // Remove item completely
  void removeFromCart(Food foodItem) {
    _cart.remove(foodItem);
    notifyListeners();
  }

  // Method to fetch products by category
  Future<void> fetchProductsByCategory(String category) async {
    final url = Uri.parse(
        'https://unicode-flutter-lp-new-final.onrender.com/get_products_by_category?category=$category');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        _foodMenu = decodedData.map((item) => Food.fromJson(item)).toList();
        notifyListeners();
      } else {
        // Handle error
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Error fetching data: $e');
    }
  }
}
