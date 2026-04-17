import 'package:joulkong/model/bike.dart';

abstract class BikeRepository {
  Future<List<Bike>> fetchBikesByIds(List<String> ids);
}
