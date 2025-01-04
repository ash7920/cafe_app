import 'package:cafe_lp/pages/models/food.dart';
import 'package:flutter/material.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final void Function()? onTap;

  const FoodTile({
    super.key,
    required this.food,
    required this.onTap,
  });

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
            food.image != null
                ? Image.network(
                    food.image!,
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  )
                : const SizedBox.shrink(),
            //text
            Text(
              food.name ?? "No Name",
              style: const TextStyle(fontSize: 20),
            ),

            // price + rating
            // Removed price and rating as they are not in the API response
          ],
        ),
      ),
    );
  }
}