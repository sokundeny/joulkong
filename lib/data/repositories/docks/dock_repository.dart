import 'package:joulkong/model/dock.dart';

abstract class DockRepository {
  Future<List<Dock>> fetchDocks();
  Future<List<Dock>> fetchDocksByStation(String stationId);
}
