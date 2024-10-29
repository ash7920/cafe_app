import 'package:cafe_lp/pages/components/button.dart';
import 'package:cafe_lp/pages/models/food.dart';
import 'package:cafe_lp/pages/models/shop.dart';
import 'package:cafe_lp/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Fooddetails extends StatefulWidget {
  final Food food;
  const Fooddetails({super.key, required this.food});
  @override
  State<Fooddetails> createState() => _FooddetailsState();
}

class _FooddetailsState extends State<Fooddetails> {
  //quantity
  int quantityCount = 0;

  //decrement quantity
  void decrementQuantity() {
    setState(() {
      if (quantityCount > 0) {
        quantityCount--;
      }
    });
  }

  //increment quantity
  void incrementQuantity() {
    setState(() {
      quantityCount++;
    });
  }

  // add to cart method
  void addToCart() {
    // only add to cart if there is something in cart
    if (quantityCount > 0) {
      //get access to shop
      final shop = context.read<Shop>();

      //add to cart
      shop.addToCart(widget.food, quantityCount);

      //let user know successfully added to cart
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: primaryColor,
          content: const Text("Item was successfully added to cart",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
              onPressed: () {
                // pop once to remove dialog box
                Navigator.pop(context);

                //pop again to go to previous screen
                Navigator.pop(context);
              },
              icon: const Icon(Icons.done),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey[900],
      ),
      body: Column(
        children: [
          //listview of food details at top
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Expanded(
                child: ListView(
              children: [
                //image
                Image.asset(
                  widget.food.imagepath,
                  height: 200,
                ),
                const SizedBox(height: 25),

                //rating
                Row(
                  children: [
                    //star icon
                    Icon(
                      Icons.star,
                      color: Colors.yellow[700],
                    ),

                    const SizedBox(width: 10),

                    //rating no
                    Text(
                      widget.food.rating,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 10),

                //food name
                Text(
                  widget.food.name,
                  style: TextStyle(fontSize: 28),
                ),

                const SizedBox(height: 25),

                //description
                Text(
                  "Welcome!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "We’re dedicated to sustainability by using eco-friendly packaging, locally-sourced ingredients, and energy-efficient practices. To support a greener future, online customers can choose our minimal-packaging option and even opt to donate a portion of their order to environmental initiatives. Together, let’s make every sip count for the planet! 🌍☕",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    height: 2,
                  ),
                ),
              ],
            )),
          ),

          // price + quantity + add to cart button

          Container(
            color: primaryColor,
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                // price + quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //price
                    Text(
                      "\ Rs." + widget.food.price,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    //quantity

                    //minus button
                    Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          icon: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                          onPressed: decrementQuantity),
                    ),
                    //quantity count
                    SizedBox(
                      width: 40,
                      child: Text(
                        quantityCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    //plus button
                    Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          icon: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                          onPressed: incrementQuantity),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                //add to cart button
                MyButton(text: "Add to Cart", onTap: addToCart),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
