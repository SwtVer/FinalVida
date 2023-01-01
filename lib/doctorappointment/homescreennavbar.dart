import 'dart:ffi';
import 'dart:ui';

import 'package:vida/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

//import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class HomeScreenNavbar extends StatelessWidget {
  const HomeScreenNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          
          height: 24,
          width: 24,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            color: kPrimaryColor,
            onPressed: (){},),
        ),
         
      ],
    );

    /*return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            image: DecorationImage(
              
                image: Svg(
              'images/arrow-small-left.svg',color: kPrimaryColor,
            )),
          ),
        ),
        
       
      ],
    );*/
  }
}
