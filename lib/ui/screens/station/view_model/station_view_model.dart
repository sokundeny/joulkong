import 'package:flutter/material.dart';
import 'package:joulkong/data/repositories/bikes/bike_repository.dart';
import 'package:joulkong/data/repositories/docks/dock_repository.dart';
import 'package:joulkong/model/bike.dart';
import 'package:joulkong/model/dock.dart';
import 'package:joulkong/model/station.dart';
import 'package:joulkong/ui/screens/station/view_model/station_item_data.dart';
import 'package:joulkong/ui/state/app_state.dart';
import 'package:joulkong/ui/utils/async_value.dart';

class StationViewModel extends ChangeNotifier {
  final DockRepository dockRepo;
  final AppState appState;
  final Station selectedStation;

  AsyncValue<List<StationItemData>> data = AsyncValue.loading();

  StationViewModel({
    required this.dockRepo,
    required this.appState,
    required this.selectedStation,
  }) {
    fetchDocks();
    appState.addListener(_onAppStateChanged);
  }

  void _onAppStateChanged() {
    notifyListeners();
    fetchDocks();
  }

  Future<void> fetchDocks() async {
    data = AsyncValue.loading();
    notifyListeners();

    try {
      List<Dock> docks = await dockRepo.fetchDocksByStation(selectedStation.id);

      final List<String> bikeIds = docks
          .where((d) => d.bikeId != null)
          .map((d) => d.bikeId!)
          .toList();

      final List<Bike> bikes = appState.fetchBikesByIds(bikeIds);

      final Map<String, Bike> bikeMap = {for (var bike in bikes) bike.id: bike};

      final List<StationItemData> items = docks.map((dock) {
        final bike = dock.bikeId != null ? bikeMap[dock.bikeId!] : null;
        return StationItemData(dock: dock, bike: bike);
      }).toList();

      data = AsyncValue.success(items);
      notifyListeners();
    } catch (e) {
      data = AsyncValue.error(e);
      notifyListeners();
    }
  }
}
