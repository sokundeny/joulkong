import 'package:flutter/material.dart';
import 'package:joulkong/data/repositories/stations/station_repository.dart';
import 'package:joulkong/data/repositories/user/user_repository.dart';
import 'package:joulkong/data/repositories/bikes/bike_repository.dart';
import 'package:joulkong/model/bike.dart';
import 'package:joulkong/model/station.dart';
import 'package:joulkong/model/subscribtion.dart';
import 'package:joulkong/model/user.dart';

enum BookingStep { loadingUser, selectPass, selectBike, booking, success, error }

class BookingViewModel extends ChangeNotifier {
  final StationRepository stationRepo;
  final UserRepository userRepo;
  final BikeRepository bikeRepo; 
  final Station station;

  BookingStep step = BookingStep.loadingUser;
  User? currentUser;
  Bike? bookedBike;
  String? errorMessage;

  List<Bike> bikes = []; 

  BookingViewModel({
    required this.stationRepo,
    required this.userRepo,
    required this.bikeRepo, 
    required this.station,
  }) {
    _loadUser();
  }

  //load
  Future<void> _loadUser() async {
    step = BookingStep.loadingUser;
    notifyListeners();

    try {
      currentUser = await userRepo.fetchCurrentUser();

      if (currentUser!.hasActivePass) {
        await _loadBikes(); // ✅ LOAD BIKES HERE
        step = BookingStep.selectBike;
      } else {
        step = BookingStep.selectPass;
      }
    } catch (e) {
      errorMessage = e.toString();
      step = BookingStep.error;
    }

    notifyListeners();
  }
  Future<void> _loadBikes() async {
    final result = await bikeRepo.fetchBikesByIds(station.bikeIds);

    bikes = result.where((b) => b.isAvailable).toList();
  }

  //pass
  Future<void> purchasePass(PassType type) async {
    step = BookingStep.loadingUser;
    notifyListeners();

    try {
      await userRepo.purchasePass(type);
      currentUser = await userRepo.fetchCurrentUser();

      await _loadBikes();
      step = BookingStep.selectBike;
    } catch (e) {
      errorMessage = e.toString();
      step = BookingStep.error;
    }

    notifyListeners();
  }

  // booking
  Future<void> bookBike(String bikeId) async {
    step = BookingStep.booking;
    notifyListeners();

    try {
      await stationRepo.bookBike(station.id, bikeId);

      bookedBike = bikes.firstWhere((b) => b.id == bikeId); 

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