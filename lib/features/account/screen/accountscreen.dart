import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vida/features/account/widget/order.dart';
import 'package:vida/features/account/widget/prescript.dart';
import 'package:vida/features/account/widget/top_botton.dart';
import 'package:vida/features/account/widget/bellowappbar.dart';
import 'package:vida/features/subscription/screens/prescription.dart';
import 'package:vida/widgets/bottom_bar.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}


class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:
    AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF1B3834),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BottomBar()))
        ), 
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
               Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 50,
                  height: 45,
                  //color: Colors.black,
                ),
              ),
              Container(
                
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      //child: Icon(Icons.notifications_outlined),
                    ),
                    /*Icon(
                      Icons.search,
                    ),*/
                  ],
                ),
              )
            ],
          ),
        ),
        body: 
           Column(
          children: const [
            BellowAppBar(),
            SizedBox(height: 10),
            TopButtons(),
            SizedBox(height: 20),
            Orders(),
            Prescription()
            
          ],
              ),
        
      );
        
  }
}
