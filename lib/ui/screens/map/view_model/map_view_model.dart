import 'package:flutter/material.dart';
import 'package:joulkong/data/repositories/stations/station_repository.dart';
import 'package:joulkong/model/station.dart';
import 'package:joulkong/ui/utils/async_value.dart';

class MapViewModel extends ChangeNotifier {
  final StationRepository stationRepo;

  AsyncValue<List<Station>> data = AsyncValue.loading();

  MapViewModel({required this.stationRepo}) {
    fetchStations();
  }

  Future<void> fetchStations() async {
    data = AsyncValue.loading();
    notifyListeners();

    try {
      final stations = await stationRepo.fetchStations();
      data = AsyncValue.success(stations);
    } catch (e) {
      data = AsyncValue.error(e.toString());
    }

    notifyListeners();
  }


}
