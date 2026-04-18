import 'package:joulkong/model/bike.dart';

abstract class BikeRepository {
  Future<List<Bike>> fetchBikesByIds(List<String> ids);
  Future<Bike> fetchBikesById(String id);
  Future<void> bookBike(String id);
}
