import 'package:cafe_lp/pages/models/shop.dart';
import 'package:cafe_lp/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl for date formatting
import 'package:provider/provider.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
      builder: (context, shop, child) {
        final orderHistory = shop.orderHistory;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Order History",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: primaryColor,
          ),
          body: orderHistory.isNotEmpty
              ? ListView.builder(
                  itemCount: orderHistory.length,
                  itemBuilder: (context, index) {
                    final order = orderHistory[index];
                    final timestamp = DateTime.parse(order['timestamp']).toLocal();
                    
                    // Format the timestamp to exclude seconds and milliseconds
                    final formattedTime = DateFormat('yyyy-MM-dd HH:mm').format(timestamp);

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text("Order #${index + 1}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Order placed at: $formattedTime"),
                            ...order['order'].entries.map((entry) {
                              return Text(
                                  "${entry.key.name}: ${entry.value} items");
                            }).toList(),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text(
                    "No order history available.",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
        );
      },
    );
  }
}
