import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:joulkong/data/repositories/stations/station_repository.dart';
import 'package:joulkong/model/station.dart';
import 'package:joulkong/ui/utils/async_value.dart';

class MapViewModel extends ChangeNotifier {
  final StationRepository stationRepo;
  final mapController = MapController();

  double _zoom = 16;

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

  double get zoom => _zoom;

  void zoomIn() {
    _zoom += 0.5;
    mapController.move(mapController.camera.center, _zoom);
    notifyListeners();
  }

  void zoomOut() {
    _zoom -= 0.5;
    mapController.move(mapController.camera.center, _zoom);
    notifyListeners();
  }
}
