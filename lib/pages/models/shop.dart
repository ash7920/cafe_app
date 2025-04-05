import 'dart:convert';
import 'package:cafe_lp/pages/models/food.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Shop extends ChangeNotifier {
  List<Food> _foodMenu = [];
  final Map<Food, int> _cart = {}; // Cart to track quantities.
  final List<Map<String, dynamic>> _orderHistory = []; // Order history

  // Getter methods
  List<Food> get foodMenu => _foodMenu;
  Map<Food, int> get cart => _cart;
  List<Map<String, dynamic>> get orderHistory => _orderHistory;

  Shop() {
    fetchFoodMenu(); // Initial fetch when the app starts
  }

  // Fetch all food items
  Future<void> fetchFoodMenu() async {
    final url = Uri.parse(
        'https://unicode-flutter-lp-new-final.onrender.com/get_all_products');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        _foodMenu = decodedData.map((item) => Food.fromJson(item)).toList();
        notifyListeners();
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Fetch products by category
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
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Add product to cart
  void addToCart(Food foodItem, int quantity) {
    if (_cart.containsKey(foodItem)) {
      _cart[foodItem] = (_cart[foodItem]! + quantity);
    } else {
      _cart[foodItem] = quantity;
    }
    notifyListeners();
  }

  // Remove one item from cart
  void removeOneFromCart(Food foodItem) {
    if (_cart.containsKey(foodItem)) {
      if (_cart[foodItem]! > 1) {
        _cart[foodItem] = _cart[foodItem]! - 1;
      } else {
        _cart.remove(foodItem);
      }
    }
    notifyListeners();
  }

  // Remove item from cart
  void removeFromCart(Food foodItem) {
    _cart.remove(foodItem);
    notifyListeners();
  }

  // Place an order
  void placeOrder() {
    if (_cart.isNotEmpty) {
      final timestamp = DateTime.now().toString();
      _orderHistory.add({
        'order': Map.from(_cart),
        'timestamp': timestamp,
      });
      _cart.clear();
      notifyListeners();
    }
  }

  // Search products based on a query
  Future<void> searchProducts(String query) async {
    if (query.isNotEmpty) {
      final url = Uri.parse(
          'https://unicode-flutter-lp-new-final.onrender.com/get_all_products?query=$query');
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final List<dynamic> decodedData = json.decode(response.body);
          _foodMenu = decodedData.map((item) => Food.fromJson(item)).toList();
          notifyListeners();
        } else {
          print('Failed to fetch data: ${response.statusCode}');
        }
      } catch (e) {
        print('Error searching products: $e');
      }
    } else {
      fetchFoodMenu(); // If the search query is empty, return to all products
    }
  }

  void setFoodMenu(List<Food> list) {}
}
