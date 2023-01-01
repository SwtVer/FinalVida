import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vida/features/account/widget/account_button.dart';
import 'package:vida/features/admin/screen/analytics_screen.dart';
import 'package:vida/features/admin/screen/order_screen.dart';
import 'package:vida/features/admin/screen/postproduct_screen.dart';
import 'package:vida/features/admin/screen/user_subscription.dart';
import 'package:vida/features/admin/services/admin_service.dart';
import 'package:vida/provider/userprovider.dart';
import 'package:vida/theme.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
     const ProductScreen(),
    const AnalyticsScreen(),
    const OrdersScreen(),
    const UserSubscription(),
    
    
    //const CartScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
    AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF1B3834),
        centerTitle: true,
          
        
        title: Row(
           // crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               Container(
                alignment:Alignment.topLeft,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 50,
                  height: 45,
                  
                ),
              ),
              Spacer(
                flex: 500,
              ),
              
              //const Text('Vida',style: TextStyle(fontWeight: FontWeight.bold,)),
              const Text('Admin',
            
              style: TextStyle(
                fontWeight: FontWeight.bold,)
                ),
              Spacer(
                flex: 100,
              ),
              
       Container(
        
        //alignment: Alignment.topLeft,
        margin: const EdgeInsets.symmetric(horizontal: 76),
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.0),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black12.withOpacity(0.03),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: () => AdminServices().logOut(context),
          child: Text(
            'Log Out',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
                
               
              
              
            ],
          ),
        ),
       body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.black12,
        backgroundColor: Colors.white,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // post
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
          
          
          // Analytics
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
                Icons.analytics_outlined,
              ),
            ),
            label: '',
          ),
          //Orders
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
              child: const Icon(
                Icons.all_inbox_outlined,
              ),
            ),
            label: '',
          ),
          //Subscription
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
