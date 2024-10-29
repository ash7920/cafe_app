import 'package:cafe_lp/pages/components/button.dart';
import 'package:cafe_lp/pages/models/food.dart';
import 'package:cafe_lp/pages/models/shop.dart';
import 'package:cafe_lp/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  //remove from cart
  void removeFromCart(Food food, BuildContext context) {
    //get access to shop
    final shop = context.read<Shop>();

    //remove from cart
    shop.removeFromCart(food);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                title: const Text("My cart",
                style: TextStyle(color: Colors.white),
                ),
                backgroundColor: primaryColor,
              ),
              body: Column(
                //customer cart
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.cart.length,
                      itemBuilder: (context, index) {
                        //get food from the cart
                        final Food food = value.cart[index];

                        //get the food name
                        final String foodName = food.name;

                        //get food price
                        final String foodPrice = food.price;

                        //return list tile
                        return Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                          child: ListTile(
                            title: Text(
                              foodName,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              foodPrice,
                              style: TextStyle(
                                color: Colors.grey[800],
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.grey[800],
                              ),
                              onPressed: () => removeFromCart(food, context),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  //pay button
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: MyButton(text: "Pay now", 
                    onTap: () {}),
                  )
                ],
              ),
            ));
  }
}
