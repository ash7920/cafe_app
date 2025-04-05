import 'package:cafe_lp/pages/models/shop.dart';
import 'package:cafe_lp/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:cafe_lp/pages/components/food_tile.dart';
import 'package:cafe_lp/pages/fooddetails.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String selectedCategory = 'ALL';

  void navigateToFoodDetails(int index) {
    final shop = context.read<Shop>();
    final foodMenu = shop.foodMenu;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Fooddetails(
          food: foodMenu[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shop = context.watch<Shop>();
    final foodMenu = shop.foodMenu;

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          icon: const Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'What are you craving today?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Increased space between AppBar and Search Bar
          const SizedBox(height: 40), 

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Search here...",
              ),
            ),
          ),
          const SizedBox(height: 25),

          // Menu header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Menu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Category Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryChip('ALL'),
                _buildCategoryChip('HOT BEVERAGES'),
                _buildCategoryChip('ICED BEVERAGES'),
                _buildCategoryChip('ADD-INS'),
                _buildCategoryChip('SYRUPS'),
                _buildCategoryChip('FOOD'),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Food List
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: foodMenu.length,
              itemBuilder: (context, index) => FoodTile(
                food: foodMenu[index],
                onTap: () => navigateToFoodDetails(index),
              ),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ChoiceChip(
        label: Text(category),
        selected: selectedCategory == category,
        onSelected: (bool selected) {
          setState(() {
            selectedCategory = category;
          });
          _filterProducts(category);
        },
        selectedColor: primaryColor,
        backgroundColor: Colors.grey[300],
        labelStyle: TextStyle(
          color: selectedCategory == category ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  void _filterProducts(String category) {
    final shop = Provider.of<Shop>(context, listen: false);
    if (category == 'ALL') {
      shop.fetchFoodMenu();
    } else {
      shop.fetchProductsByCategory(category);
    }
  }
}
