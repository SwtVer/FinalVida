import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vida/constants/httperror.dart';
import 'package:vida/constants/uri.dart';
import 'package:vida/constants/util.dart';
import 'package:vida/models/order.dart';
import 'package:vida/models/user.dart';
import 'package:vida/provider/userprovider.dart';
import 'package:http/http.dart' as http;

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
    //required String userId,

  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
          //'id': userId,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Your adrress has been placed!');
          User user = userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );

          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all the products
  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('deg8khhsw', 'tpgl2eog');
      //mapping all product images and sending it to the cloudanary storage
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: category),
        );
        imageUrls.add(res.secureUrl);
      }
      //uploading urls of images in mongodb
      /*Order orderModel = Order(
          
          address: address,
            totalPrice: totalSum,
            category: category,
            images:imageUrls

          
          );*/
      http.Response res = await http.post(Uri.parse('$uri/api/order'),

          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalSum,
            'category': category,
            'images':imageUrls
          }));

      httpErrorHandle(
        response: res,  
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Your order has been placed!');
          User user = userProvider.user.copyWith(
            cart: [],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
