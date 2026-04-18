import 'package:flutter/material.dart';
import 'package:joulkong/model/bike.dart';
import 'package:joulkong/model/dock.dart';
import 'package:joulkong/ui/state/app_state.dart';

enum BookingStep {
  selectPass,
  selectBike,
  booking,
  success,
  error,
}

class BookingViewModel extends ChangeNotifier {
  Dock dock;
  final AppState appState;

  BookingStep step = BookingStep.selectPass;
  Bike? bookedBike;
  String? errorMessage;

  List<Bike> bikes = [];

  BookingViewModel({required this.dock, required this.appState}) {
    init();
  }

  void _onAppStateChanged() {
    if (appState.isSubscribed && step == BookingStep.selectPass) {
      step = BookingStep.selectBike;
    }
    notifyListeners();
  }

  void init() {
    // Load bikes available
    if (dock.bikeId != null) {
      bikes = appState.fetchBikesByIds([dock.bikeId!]);
    }

    if (appState.isSubscribed) {
      step = BookingStep.selectBike;
    } else {
      step = BookingStep.selectPass;
    }

    appState.addListener(_onAppStateChanged);
    notifyListeners();
  }

  Future<void> bookBike(String bikeId) async {
    step = BookingStep.booking;
    notifyListeners();

    try {
      await appState.bookBike(bikeId);
      bookedBike = bikes.firstWhere((b) => b.id == bikeId);
      step = BookingStep.success;
    } catch (e) {
      errorMessage = e.toString();
      step = BookingStep.error;
    }

    notifyListeners();
  }

  String? get blockingReason {
    if (bikes.isEmpty) return "No bikes available";
    return null;
  }

  bool get canBook => blockingReason == null;

  List<Bike> get availableBikes => bikes;

  @override
  void dispose() {
    appState.removeListener(_onAppStateChanged);
    super.dispose();
  }
}