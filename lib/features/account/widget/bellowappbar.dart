import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:vida/provider/userprovider.dart';
import 'package:vida/theme.dart';

class BellowAppBar extends StatelessWidget {
  const BellowAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10), 
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: 'Hello, ',
              style:  const TextStyle(
                    fontSize: 22,
                    color: Color(0xFF1B3834),
                    fontWeight: FontWeight.w600,
                  ),
              
              children: [
                TextSpan(
                  text: user.name,
                  style: titleText
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
