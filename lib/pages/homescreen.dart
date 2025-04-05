import 'package:cafe_lp/pages/models/food.dart';
import 'package:cafe_lp/pages/models/shop.dart';
import 'package:cafe_lp/pages/profile.dart';
import 'package:cafe_lp/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:cafe_lp/pages/menu.dart';
import 'package:cafe_lp/pages/cart.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Navigate to selected page
  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MenuPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Cart()),
        );
        break;
      case 2:
     Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final shop = context.watch<Shop>();
    final foodMenu = shop.foodMenu;

    // Generate random indices for bestsellers, recommendations, and favorites
    final random = Random();
     final bestsellerIndex = foodMenu.isNotEmpty ? random.nextInt(foodMenu.length) : null;
      final favoriteIndex = foodMenu.isNotEmpty ? random.nextInt(foodMenu.length) : null;


     // Get the items based on the random indices
    final Food? bestseller = bestsellerIndex != null ? foodMenu[bestsellerIndex] : null;
      final Food? favorite = favoriteIndex != null ? foodMenu[favoriteIndex] : null;


    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getTitle(),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      backgroundColor: secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bestseller
            if (bestseller != null)
              Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded( // Use Expanded to constrain text width
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Our Bestsellers:',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            bestseller.name ?? "No Name",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                           const SizedBox(height: 10),
                          // Removed price as it's not in the API response
                        ],
                      ),
                    ),
                    const SizedBox(width: 10), // Space between text and image
                    // Image
                    if (bestseller.image != null)
                        Image.network(
                          bestseller.image!,
                          height: 100,
                       ) else const SizedBox.shrink(),
                  ],
                ),
              ),

            // Recommendations Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                "Recommendations",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 10),

             // Horizontal Scrollable Recommendations
            SizedBox(  // Use SizedBox to constrain horizontal scroll view height
            height: 170,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 25),
               itemCount:  min(3, foodMenu.length),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index){
                   final random = Random();
                  int randomIndex;
                   Set<int> usedIndices = {};

                  do {
                    randomIndex = random.nextInt(foodMenu.length);
                  } while(usedIndices.contains(randomIndex));

                  usedIndices.add(randomIndex);

                  final food = foodMenu[randomIndex];
                  return  _buildRecommendationItem(
                      imageUrl: food.image,
                      title: food.name ?? "No Name",
                    );
              } ,
             ),
            ),

            const SizedBox(height: 25),

            // Favorites Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Favourites",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Favorite Item
            if (favorite != null)
              _buildFavoriteItem(
                imageUrl: favorite.image,
                title: favorite.name ?? "No Name",
                ),
              const SizedBox(height: 25), // Add some space at the bottom

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: _navigateToPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem({
    String? imageUrl,
    required String title,
  }) {
     return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        image: imageUrl != null
            ? DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.35), // Darken the image
                  BlendMode.darken,
                ),
              )
            : null,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Removed price as it's not in the API response
          ],
        ),
      ),
    );
  }

 Widget _buildFavoriteItem({
  String? imageUrl,
  required String title,
}) {
  return Container(
    decoration: BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.circular(20),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
    padding: const EdgeInsets.all(20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
      children: [
        if (imageUrl != null)
          Image.network(
            imageUrl,
            height: 100,
            width: 100, // Set fixed width for the image
            fit: BoxFit.cover,
          ),
        const SizedBox(width: 10), // Space between image and text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                maxLines: 2, // Limit text to 2 lines
                overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
              ),
              const SizedBox(height: 10),
              // Removed price as it's not in the API response
            ],
          ),
        ),
        const Icon(
          Icons.favorite,
          size: 28,
          color: Color.fromARGB(255, 147, 12, 3),
        ),
      ],
    ),
  );
}


  String _getTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Home';
      case 2:
        return 'Home';
      default:
        return 'Cafe LP';
    }
  }
}

