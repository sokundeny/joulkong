import 'package:joulkong/model/station.dart';

abstract class StationRepository {
  Future<List<Station>> fetchStations();
  Future<void> bookBike(String stationId, String bikeId);
}