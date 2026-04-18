import 'package:joulkong/data/repositories/docks/dock_repository.dart';
import 'package:joulkong/model/dock.dart';

class DockRepositoryMock extends DockRepository {
  final _docks = [
    Dock(number: 1, stationId: '00001', bikeId: 'BIKE_001'),
    Dock(number: 2, stationId: '00001'),
    Dock(number: 3, stationId: '00001', bikeId: 'BIKE_002'),
    Dock(number: 4, stationId: '00001', bikeId: 'BIKE_003', isLocked: true),

    // Dock(number: 1, stationId: '00002'),
    Dock(number: 1, stationId: '00002', bikeId: 'BIKE_004'),
    Dock(number: 2, stationId: '00002', bikeId: 'BIKE_005'),
    Dock(number: 3, stationId: '00002'),
  
    Dock(number: 1, stationId: '00003', bikeId: 'BIKE_006'),
    Dock(number: 2, stationId: '00003'),
    Dock(number: 3, stationId: '00003', bikeId: 'BIKE_007'),
    Dock(number: 4, stationId: '00003', bikeId: 'BIKE_008', isLocked: true),
  ];

  @override
  Future<List<Dock>> fetchDocks() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => _docks
    );
  }

  @override
  Future<List<Dock>> fetchDocksByStation(String stationId) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => _docks.where((dock) => dock.stationId == stationId).toList(),
    );
  }
}
