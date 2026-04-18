import 'package:flutter/material.dart';
import 'package:joulkong/model/user_subscription.dart';

class AppState extends ChangeNotifier {
  UserSubscription? userSubscription;

  void setUserSubscription(UserSubscription sub) {
    userSubscription = sub;
    notifyListeners();
  }

  bool get isSubscribed => userSubscription?.isActive ?? false;
}
