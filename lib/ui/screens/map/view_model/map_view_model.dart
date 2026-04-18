import 'package:flutter/material.dart';
import 'package:joulkong/data/repositories/bikes/bike_repository.dart';
import 'package:joulkong/data/repositories/docks/dock_repository.dart';
import 'package:joulkong/data/repositories/stations/station_repository.dart';
import 'package:joulkong/model/bike.dart';
import 'package:joulkong/ui/screens/map/view_model/map_data.dart';
import 'package:joulkong/ui/state/app_state.dart';
import 'package:joulkong/ui/utils/async_value.dart';

class MapViewModel extends ChangeNotifier {
  final StationRepository stationRepo;
  final DockRepository dockRepo;
  final AppState appState;

  AsyncValue<List<MapData>> data = AsyncValue.loading();

  MapViewModel({
    required this.stationRepo,
    required this.dockRepo,
    required this.appState,
  }) {
    appState.addListener(_onAppStateChanged);
    fetchMapData();
  }

  void _onAppStateChanged() {
    notifyListeners();
    fetchMapData();
  }

  Future<void> fetchMapData() async {
    data = AsyncValue.loading();
    notifyListeners();

    try {
      final stations = await stationRepo.fetchStations();

      final futures = stations.map((station) async {
        final docks = await dockRepo.fetchDocksByStation(station.id);

        final bikeIds = docks
            .where((d) => d.bikeId != null)
            .map((d) => d.bikeId!)
            .toList();

        final bikes = bikeIds.isEmpty ? <Bike>[] : appState.fetchBikesByIds(bikeIds);

        return MapData(
          station: station,
          docks: docks.length,
          bikes: bikes.where((bike)=>bike.status==BikeStatus.available).length,
        );
      }).toList();

      final result = await Future.wait(futures);

      data = AsyncValue.success(result);
    } catch (e) {
      data = AsyncValue.error(e.toString());
    }

    notifyListeners();
  }

  @override
  void dispose() {
    appState.removeListener(_onAppStateChanged);
    super.dispose();
  }
}
