import 'package:flutter/material.dart';
import 'package:joulkong/data/repositories/bikes/bike_repository.dart';
import 'package:joulkong/model/bike.dart';
import 'package:joulkong/model/user_subscription.dart';

class AppState extends ChangeNotifier {
  UserSubscription? userSubscription;
  List<Bike> bikes = [];

  AppState({required BikeRepository repo}) {
    _init(repo: repo);
  }

  void _init({required BikeRepository repo}) async {
    bikes = await repo.fetchAllBike();
    notifyListeners();
  }

  void setUserSubscription(UserSubscription sub) {
    userSubscription = sub;
    notifyListeners();
  }

  List<Bike> fetchBikesByIds(List<String> ids) {
    return bikes.where((bike) => ids.contains(bike.id)).toList();
  }

  bool get isSubscribed => userSubscription?.isActive ?? false;

  Future<void> bookBike(String id)async {
    final index = bikes.indexWhere((b) => b.id == id);
    if (index != -1) {
      bikes[index] = Bike(id: bikes[index].id, status: BikeStatus.booked);
      notifyListeners();
    }
    print(bikes[index].status);
  }
}
