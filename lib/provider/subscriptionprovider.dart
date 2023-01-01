import 'package:flutter/material.dart';
import 'package:vida/models/subscription.dart';

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionModel _user = SubscriptionModel(
    description: '',
    userId: '',
    images: [],
    category: '',
    orderedAt: '',
    id: '',
   
  );

  SubscriptionModel get user => _user;

  void setUser(String user) {
    _user = SubscriptionModel.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(SubscriptionModel user) {
    _user = user;
    notifyListeners();
  }
}
