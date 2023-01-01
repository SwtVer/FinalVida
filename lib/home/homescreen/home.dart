import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vida/constants/globalVariable.dart';
import 'package:vida/models/user.dart';
import 'package:vida/provider/userprovider.dart';
import 'package:vida/home/homescreen/address_box.dart';
//import 'package:vida/screens/homescreen/category.dart';
import 'package:vida/home/homescreen/categorylist.dart';
import 'package:vida/home/homescreen/categoryscreen.dart';
//import 'package:vida/screens/homescreen/detail_screen.dart';
import 'package:vida/features/search/screen/search.dart';
import 'package:vida/home/medicinedetail/allopathy/allopathy.dart';
import 'package:vida/home/medicinedetail/ayurvedic/ayurvedic.dart';
import 'package:vida/home/medicinedetail/homeopathy/homeopathy.dart';
import 'package:vida/home/medicinedetail/otc/otc.dart';
import 'package:vida/theme.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';
  const Home({Key? key}) : super(key: key);
  void navigateToCategoryPage( BuildContext context,String category){
    Navigator.pushNamed(context,CategoryScreen.routeName,arguments:category);
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .35,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 27, 56, 52)
              //image: DecorationImage(
              //alignment: Alignment.centerLeft,
              //image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              // ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 2, 117, 40),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset("assets/images/logo.png", ),
                    ),
                  ),
                  
                  Text(
                    "Welcome",
                    style: TextStyle(
                        color: Colors.white, fontSize: 40, fontWeight: FontWeight.w500),
                    
                  ),
                  SearchBar(),
                  SizedBox(
                    height: 10,
                  ),
                  AddressBox(),
                  SizedBox(
                    height: 10,
                  ),
                  /*GestureDetector(
                    //onTap: () => navigateToCategoryPage(context,GlobalVariables)
                    child: Column(
                     
                        children: const [
                          TopCategories(),
                        ]
                        
                      ),
                    )*/
                    TopCategories(),
                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
