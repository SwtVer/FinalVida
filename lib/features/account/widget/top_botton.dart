import 'package:flutter/material.dart';
import 'package:vida/features/account/screen/profile.dart';
import 'package:vida/features/account/services/account_service.dart';
import 'package:vida/features/account/widget/account_button.dart';
import 'package:vida/features/account/widget/yourorder.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            /*AccountButton(
              text: 'Your Wish List',
              onTap: () {
                Navigator.pushNamed(
                          context,
                          YourOrder.routeName,
                          
                        );
              },
            ),*/
            /* AccountButton(text: 'Your Profile', 
            onTap: () => { 
              Navigator.pushNamed(
                          context,
                          Profile.routeName,
                          
                        )}
            ),*/
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              onTap: () => AccountServices().logOut(context),
            ),
            AccountButton(
              text: 'Your Orders',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  YourOrder.routeName,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
