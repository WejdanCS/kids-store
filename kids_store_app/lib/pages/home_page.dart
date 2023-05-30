import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kids_store_app/pages/favorite_page.dart';
import 'package:kids_store_app/pages/home_products.dart';
import 'package:kids_store_app/pages/orders_page.dart';
import 'package:kids_store_app/pages/profile_page.dart';
import 'package:kids_store_app/utlis/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Constants.primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
          // Respond to item press.
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'الرئيسية',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'الطلبات',
            icon: Icon(Icons.shopping_basket),
          ),
          BottomNavigationBarItem(
            label: 'المفضلة',
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: 'الملف الشخصي',
            icon: Icon(Icons.person_2),
          ),
        ],
      ),
      body: SafeArea(
          child: SizedBox(
              width: screenSize.width,
              child: _currentIndex == 0
                  ? HomeProducts()
                  : _currentIndex == 1
                      ? OrdersPage()
                      : _currentIndex == 2
                          ? FavoritePage()
                          : ProfilePage())),
    );
  }
}
