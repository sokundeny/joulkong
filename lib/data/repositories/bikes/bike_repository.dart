import 'package:joulkong/model/bike.dart';

abstract class BikeRepository {
  Future<List<Bike>> fetchBikesByIds(List<String> ids);
  Future<Bike> fetchBikesById(String id);
  Future<List<Bike>> fetchAllBike();

  Future<void> bookBike(String id); 
}
