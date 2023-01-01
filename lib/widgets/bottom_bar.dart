import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vida/features/account/screen/accountscreen.dart';
import 'package:vida/features/cart/screen/cartscreen.dart';
import 'package:vida/features/subscription/screens/prescription.dart';
import 'package:vida/features/subscription/screens/subscription%20_option%20.dart';
import 'package:vida/provider/userprovider.dart';
import 'package:vida/theme.dart';

import '../home/homescreen/home.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const Home(),
    const Account(),
    const CartScreen(),
    const Subscription(),
    
    
    
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;//context.watch is short form of provider.of context..

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.black12,
        backgroundColor: Colors.white,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? kPrimaryColor
                        : Colors.white,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),
          
          
          // Profile
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? kPrimaryColor
                        : Colors.white,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.person_outline_outlined,
              ),
            ),
            label: '',
          ),
          // CART
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? kPrimaryColor
                        : Colors.white,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              
              child: Badge(
                elevation: 0,
                badgeContent: Text(userCartLen.toString()),//userCartLen.toString()),
                badgeColor: Colors.white,
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              )
              ),
               label: '',
            ),
            //subscription
            BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 3
                        ? kPrimaryColor
                        : Colors.white,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.subscriptions_rounded,
              ),
            ),
            label: '',
          ),
            
        ]
           
      
      ),
    );
  }
}