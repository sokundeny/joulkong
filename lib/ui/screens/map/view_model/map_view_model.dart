import 'package:flutter/material.dart';
import 'package:joulkong/data/repositories/docks/dock_repository.dart';
import 'package:joulkong/data/repositories/stations/station_repository.dart';
import 'package:joulkong/model/bike.dart';
import 'package:joulkong/model/dock.dart';
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
    fetchMapData();
  }

  Future<void> fetchMapData() async {
    data = AsyncValue.loading();
    notifyListeners();

    try {
      final stations = await stationRepo.fetchStations();
      final docks = await dockRepo.fetchDocks();

      final bikeIds = docks
          .where((dock) => dock.bikeId != null)
          .map((dock) => dock.bikeId!)
          .toSet()
          .toList();

      final List<Bike> bikes = bikeIds.isEmpty
          ? <Bike>[]
          : appState.fetchBikesByIds(bikeIds);

      final Map<String, List<Dock>> dockByStation = {};
      for (final dock in docks) {
        dockByStation.putIfAbsent(dock.stationId, () => <Dock>[]);
        dockByStation[dock.stationId]!.add(dock);
      }

      final Map<String, Bike> bikeById = {
        for (final bike in bikes) bike.id: bike,
      };

      final List<MapData> result = stations.map((station) {
        final List<Dock> stationDocks = dockByStation[station.id] ?? <Dock>[];

        final int bikeCount = stationDocks.where((dock) {
          final bikeId = dock.bikeId;
          if (bikeId == null) return false;

          final bike = bikeById[bikeId];
          if (bike == null) return false;

          return bike.status == BikeStatus.available;
        }).length;

        return MapData(
          station: station,
          docks: stationDocks.length,
          bikes: bikeCount,
        );
      }).toList();

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
