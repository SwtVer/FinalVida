import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vida/constants/globalVariable.dart';
//import 'package:vida/screens/homescreen/category.dart';
import 'package:vida/home/homescreen/categoryscreen.dart';
import 'package:vida/theme.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryScreen.routeName, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      //height: 100,
      child: GridView.builder(
          itemCount: GlobalVariables.categoryImages.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .85,
            crossAxisSpacing: 50,
            mainAxisSpacing: 50,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              child:  Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      
          color: Colors.white,
          
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: kShadowColor,
            ),
          ],
        ),
                        height: 150,
                        
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        //child:Card (
                          
                          child: SvgPicture.asset(
                        
                            GlobalVariables.categoryImages[index]['image']!,
                            fit: BoxFit.fill,
                            height: 300,
                            width: 300,
                          ),
                        
                  ),
                  SizedBox(
                       height: 10,
                  ),
                  Text(
                    GlobalVariables.categoryImages[index]['title']!,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
                  
                  
              

             
                onTap: () => navigateToCategoryPage(
                      context,
                      GlobalVariables.categoryImages[index]['title']!,
                    ));
                    
          }),
    );

    /*child: ListView.builder(
        
        itemCount: GlobalVariables.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 90,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToCategoryPage(
              context,
              GlobalVariables.categoryImages[index]['title']!,
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                children: [
                  Container(
                    height: 85,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SvgPicture.asset(
                        GlobalVariables.categoryImages[index]['image']!,
                        fit: BoxFit.fill,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  Text(
                    GlobalVariables.categoryImages[index]['title']!,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }*/
  }
}
