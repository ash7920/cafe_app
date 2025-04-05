import 'package:cafe_lp/pages/components/button.dart';
import 'package:cafe_lp/pages/models/shop.dart';
import 'package:cafe_lp/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
      builder: (context, shop, child) {
        final cartItems = shop.cart;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "My Cart",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: primaryColor,
          ),
          body: Column(
            children: [
              Expanded(
                child: cartItems.isNotEmpty
                    ? ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final food = cartItems.keys.toList()[index];
                          final quantity = cartItems[food]!;

                          return Container(
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.all(10.0),
                            child: ListTile(
                              title: Text(
                                food.name ?? "No Name",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text("Quantity: $quantity"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      shop.removeOneFromCart(food);
                                    },
                                  ),
                                  Text(
                                    quantity.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      shop.addToCart(food, 1);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          "Your cart is empty",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: MyButton(
                  text: "Place Order",
                  onTap: () {
                    // Add the current cart items to order history and clear cart
                    shop.placeOrder();
                    // Navigate to the order history page
                    Navigator.pushNamed(context, '/orderHistory');
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
