
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vida/provider/userprovider.dart';
import 'package:vida/theme.dart';

class AddressBoxCart extends StatelessWidget {
  const AddressBoxCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      height: 40,
      //crossAxisAlignment: CrossAxisAlignment.start,
      //width: 40,
      decoration:  BoxDecoration(
        //borderRadius: BorderRadius.circular(29.5),
        gradient: LinearGradient(
          colors: [
           // Color.fromARGB(255, 65, 147, 92),
            Color.fromARGB(255, 27, 56, 52),
            Color.fromARGB(255, 33, 81, 74),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Icon(
            color:Colors.white70,
            Icons.location_on_outlined,
            size: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Delivery to ${user.name} - ${user.address}',
                style: const TextStyle(
                 color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
         
        ],
      ),
    );
  }
}