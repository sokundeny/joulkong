import 'package:flutter/material.dart';
import 'package:joulkong/data/repositories/bikes/bike_repository.dart';
import 'package:joulkong/model/bike.dart';
import 'package:joulkong/model/dock.dart';
import 'package:joulkong/model/user.dart';
import 'package:joulkong/ui/state/app_state.dart';

enum BookingStep {
  loadingUser,
  selectPass,
  selectBike,
  booking,
  success,
  error,
}

class BookingViewModel extends ChangeNotifier {
  Dock dock;
  final AppState appState;
  final BikeRepository bikeRepo;

  BookingStep step = BookingStep.loadingUser;
  User? currentUser;
  Bike? bookedBike;
  String? errorMessage;

  List<Bike> bikes = [];

  BookingViewModel({required this.dock, required this.appState, required this.bikeRepo}) {
    init();
  }

  void init() {
    if (appState.isSubscribed) {
      step = BookingStep.selectBike;
    } else {
      step = BookingStep.selectPass;
    }
    notifyListeners();
  }

  // booking
  Future<void> bookBike(String bikeId) async {
    step = BookingStep.booking;
    notifyListeners();

    try {
      await bikeRepo.bookBike(bikeId);
      bookedBike = await bikeRepo.fetchBikesById(bikeId);

      appState.bookBike();

      step = BookingStep.success;
    } catch (e) {
      errorMessage = e.toString();
      step = BookingStep.error;
    }

    notifyListeners();
  }

  //status validate
  String? get blockingReason {
    if (bikes.isEmpty) {
      return "No bikes available";
    }

    if (currentUser == null) {
      return "Loading user...";
    }

    if (!currentUser!.hasActivePass) {
      return "You need a pass to book a bike";
    }

    return null;
  }

  bool get canBook => blockingReason == null;

  List<Bike> get availableBikes => bikes;
}
