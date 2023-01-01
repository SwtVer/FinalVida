import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vida/provider/userprovider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            'TOTAL',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            '\NPR.$sum',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}