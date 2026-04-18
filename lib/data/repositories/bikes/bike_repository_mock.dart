import 'package:joulkong/data/repositories/bikes/bike_repository.dart';
import 'package:joulkong/model/bike.dart';

class BikeRepositoryMock extends BikeRepository {
  final List<Bike> _bikes = [
    Bike(id: 'BIKE_001', status: BikeStatus.available),
    Bike(id: 'BIKE_002', status: BikeStatus.available),
    Bike(id: 'BIKE_003', status: BikeStatus.available),
    Bike(id: 'BIKE_004', status: BikeStatus.available),
    Bike(id: 'BIKE_005', status: BikeStatus.available),
    Bike(id: 'BIKE_006', status: BikeStatus.available),
    Bike(id: 'BIKE_007', status: BikeStatus.available),
    Bike(id: 'BIKE_008', status: BikeStatus.available),
  ];

  @override
  Future<List<Bike>> fetchBikesByIds(List<String> ids) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => _bikes.where((bike) => ids.contains(bike.id)).toList(),
    );
  }

  @override
  Future<Bike> fetchBikesById(String id) async {
    return Future.delayed(
      const Duration(seconds: 0),
      () => _bikes.firstWhere((bike) => id == bike.id),
    );
  }

  @override
  Future<List<Bike>> fetchAllBike() async {
    return _bikes;
  }

  @override 
  Future<void> bookBike(String id) async {
    return Future.delayed(const Duration(seconds: 1), () {
      final index = _bikes.indexWhere((bike) => bike.id == id);

      if (index == -1) {
        throw Exception('Bike not found');
      }

      final bike = _bikes[index];

      if (bike.status != BikeStatus.available) {
        throw Exception('Bike is not available');
      }

      final updatedBike = bike.copyWith(status: BikeStatus.booked);
      _bikes[index] = updatedBike;

    });
  }
}
