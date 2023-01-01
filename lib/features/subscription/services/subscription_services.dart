import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vida/constants/httperror.dart';
import 'package:vida/constants/uri.dart';
import 'package:vida/constants/util.dart';
import 'package:http/http.dart' as http;
import 'package:vida/features/subscription/screens/subscription%20_option%20.dart';
import 'package:vida/models/subscription.dart';
import 'package:vida/provider/subscriptionprovider.dart';
import 'package:vida/provider/userprovider.dart';

class SubcriptionServices {
  void addsubscription(
      {required BuildContext context, //to display errors

      required String description,
      required String category,
      required List<File> images,
      required String userId,
      required String orderedAt
      //required SubscriptionModel product
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
      SubscriptionModel subscriptionModel = SubscriptionModel(
          description: description,
          images: imageUrls,
          category: category,
          userId: userId,
          orderedAt: orderedAt);
      http.Response res =
          await http.post(Uri.parse('$uri/api/add-subscription'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: subscriptionModel.toJson()
              //subscriptionModel.toJson(),
              );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Prescription Added Successfully!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get- subscription

  Future<List<SubscriptionModel>> fetchMySubscription({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    List<SubscriptionModel> subscriptionList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/get-subscription'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            subscriptionList.add(
              SubscriptionModel.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return subscriptionList;
  }

  void deleteSubscription({
    required BuildContext context,
    required SubscriptionModel product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
   

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/delete-subscription'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  /*//get all products
  //return all products by converting them from json to product model
  Future<List<SubscriptionModel>> fetchAllSubscription(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<SubscriptionModel> subscriptionList =
        []; // get data as we convert json to product model
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-subscription'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      //jsonencode json decode
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            subscriptionList.add(
              SubscriptionModel.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return subscriptionList;
  }*/
}
