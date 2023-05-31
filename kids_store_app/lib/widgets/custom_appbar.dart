import 'package:flutter/material.dart';
import 'package:kids_store_app/pages/cart_page.dart';
import 'package:kids_store_app/utlis/constants.dart';

class CustomAppBar extends StatelessWidget {
  final Widget child;
  const CustomAppBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          child,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Constants.primaryColor,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => CartPage(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Constants.primaryColor,
                  )),
            ],
          ),
        ],
      )),
    );
  }
}
