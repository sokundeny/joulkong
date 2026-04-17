import 'package:joulkong/model/station.dart';

abstract class StationRepository {
  Future<List<Station>> fetchStations();
}
