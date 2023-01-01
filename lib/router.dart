import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vida/features/Esewa/screen/esewa.dart';
import 'package:vida/features/account/screen/profile.dart';
import 'package:vida/features/account/widget/prescript.dart';
import 'package:vida/features/account/widget/yourorder.dart';

import 'package:vida/features/address/screen/address_screen.dart';
import 'package:vida/features/admin/screen/add_product.dart';
import 'package:vida/features/admin/screen/postproduct_screen.dart';
import 'package:vida/features/admin/widgets/product_detail.dart';
import 'package:vida/features/auth/screens/auth_screen.dart';
import 'package:vida/features/esewaa/esewaa.dart';
import 'package:vida/features/order_detail/oder_detail_screen.dart';
import 'package:vida/features/product_detail/screens/productdetailScreen.dart';
import 'package:vida/features/search/screen/searchscreen.dart';
import 'package:vida/features/subscription/screens/prescription.dart';
import 'package:vida/features/subscription/screens/subscription_form.dart';
import 'package:vida/home/homescreen/categoryscreen.dart';
import 'package:vida/home/homescreen/home.dart';

import 'package:vida/home/login.dart';
import 'package:vida/home/signup.dart';
import 'package:vida/models/order.dart';
import 'package:vida/models/productmodel.dart';
import 'package:vida/models/subscription.dart';
import 'package:vida/widgets/bottom_bar.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LogInScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const LogInScreen());

    case Home.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const Home());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());
    case AddProduct.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProduct());
    case CategoryScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryScreen(
                category: category,
              ));

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ));
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailScreen(
                product: product,
              ));
    case ProductDetail.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetail(
                product: product,
              ));
    case AddressScreen.routeName:
    
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
          
        ),
      );
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );
    case YourOrder.routeName:
     // var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => YourOrder(
         // order: order,
        ),
      );
    case EsewaEpay.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => EsewaEpay(
          totalAmount: totalAmount,
        ),
      );
    case SubscriptionForm.routeName:
      //var subscriptionModel = routeSettings.arguments as SubscriptionModel;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SubscriptionForm(
           //subscriptionModel: subscriptionModel,
          ));

    case PrescriptionScreen.routeName:
      var subscriptionModel = routeSettings.arguments as SubscriptionModel;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => PrescriptionScreen(
          subscriptionModel: subscriptionModel,
        ),
      );
    case Profile.routeName:
      //var subscriptionModel = routeSettings.arguments as SubscriptionModel;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Profile(
          //subscriptionModel: subscriptionModel,
        ),
      );
    case Payment.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Payment(
          totalAmount: totalAmount,
        ),
      );

    /*case 
         SignUpScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => LogInScreen());*/
    /* case SubscriptionForm.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SubscriptionForm());*/
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => Scaffold(
                body: Center(
                  child: Text('Screen does not exist'),
                ),
              ));
  }
}
