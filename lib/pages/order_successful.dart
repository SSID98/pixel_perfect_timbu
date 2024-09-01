import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderSuccessful extends StatelessWidget {
  static const String id = 'order_successful_page';

  const OrderSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.star_circle_fill,
                color: Colors.green,
                size: 150.0,
              ),
              Text(
                'Order Successful',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }
}
