import 'package:cafe_lp/pages/models/food.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier {
  final List<Food> _foodMenu = [
    //cappuchino
    Food(
        name: "Cappuchino",
        price: "Rs. 190",
        imagepath: "assets/images/unsplash_wd_j_5_txrg_7_k_1.jpeg",
        rating: "4.3",
        description: "A classic Cappuccino brewed to perfection with our rich, full-bodied espresso and steamed milk, topped with a delicate foam. Elevate your experience with a choice of almond, soy, or oat milk for a creamy, dairy-free delight that’s as smooth as it is satisfying. "
        ),

    //espresso
    Food(
        name: "Espresso",
        price: "Rs. 150",
        imagepath: "assets/images/espresso.jpg",
        rating: "4.7",
        description: "For the true coffee connoisseur, our Espresso is an intense shot of robust, aromatic coffee. Perfectly balanced with rich, bold flavors and a smooth finish, it’s available in decaf for those looking for all the taste, without the caffeine rush. "
        ),

    //iced mocha
    Food(
        name: "Iced Mocha",
        price: "Rs. 230",
        imagepath: "assets/images/unsplashv_zozjh_xk_uk_1.jpeg",
        rating: "4.3",
        description: "Our Iced Mocha is a refreshing blend of rich espresso, smooth cocoa, and chilled milk, all topped with a light drizzle of chocolate. Customize with almond, soy, or oat milk for a luxurious, dairy-free twist that’s perfect for a sunny day pick-me-up. "
        ),

    //avocado toast
    Food(
        name: "Avocado Toast",
        price: "Rs. 250",
        imagepath: "assets/images/avocadotoast.jpg",
        rating: "4.5",
        description: "A vibrant twist on a cafe classic, our Avocado Toast is served on freshly toasted artisan bread, lavishly topped with creamy, ripe avocado. Sprinkled with a hint of sea salt and chili flakes, it’s vegan, with gluten-free bread available for an even healthier start to your day. "
        ),

    //chocolate croissant
    Food(
        name: "Chocolate Croissant",
        price: "Rs. 160",
        imagepath: "assets/images/chocolatecroissant.jpg",
        rating: "4.6",
        description: "Indulge in our flaky, golden Chocolate Croissant, filled with decadent, melted chocolate. Baked fresh daily, each bite is a heavenly combination of crisp, buttery layers and rich chocolatey goodness, crafted for those who truly appreciate a gourmet pastry experience. "
        ),

    //blueberry muffin
    Food(
        name: "Blueberry Muffin",
        price: "Rs. 130",
        imagepath: "assets/images/blueberrymuffin.jpg",
        rating: "4.3",
        description: "Bursting with juicy, fresh blueberries, our gluten-free Blueberry Muffin is a soft, moist delight. Lightly sweetened and baked to perfection, it pairs beautifully with any coffee or tea, making it the ideal treat for those with a sweet tooth. "
        ),

    //burrito bowl
    Food(
        name: "Burrito Bowl",
        price: "Rs. 280",
        imagepath: "assets/images/burritobowl.jpg",
        rating: "4.5",
        description: "Packed with vibrant flavors, our Burrito Bowl features a bed of seasoned rice, hearty black beans, grilled veggies, and fresh guacamole, all topped with a dollop of sour cream and tangy salsa. Vegan and gluten-free, it’s a nourishing and satisfying choice that doesn’t compromise on flavor. "
        ),

    //acai bowl
    Food(
        name: "Acai Bowl",
        price: "Rs. 200",
        imagepath: "assets/images/acaibowl.jpg",
        rating: "4.6",
        description: "Our Acai Bowl is a refreshing and antioxidant-rich blend of acai, topped with a colorful mix of fresh berries, banana slices, crunchy granola, and a drizzle of honey. Vegan and gluten-free, it’s a nutrient-packed treat that brings a delightful burst of flavor with every spoonful. "
        ),
  ];

  //customers cart
  final List<Food> _cart = [];

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
