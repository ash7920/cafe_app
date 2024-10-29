import 'package:cafe_lp/pages/models/food.dart';
import 'package:flutter/material.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;

  const FoodTile({
    super.key,
    required this.food,
    required this.onTap,
  }
);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(25),
      
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // image
            Image.asset(
              food.imagepath,
              height: 300,
              width: 300,
              ),
      
            //text
            Text(
              food.name,
              style: TextStyle(fontSize: 20),
            ),
      
            // price + rating
            SizedBox(
              width: 160,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //price
                  Text('\ Rs.' + food.price,
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    color: Colors.grey[700]),
                  ),
      
                  //rating
                  Icon(Icons.star,
                  color: Colors.yellow[700],
                  ),
                  Text(food.rating,
                  style: TextStyle(color: Colors.grey[700]),
                  ), 
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
