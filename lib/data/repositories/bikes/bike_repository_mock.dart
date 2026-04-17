
import 'package:joulkong/data/repositories/bikes/bike_repository.dart';
import 'package:joulkong/model/bike.dart';

class BikeRepositoryMock extends BikeRepository {
  final List<Bike> _bikes = [
    Bike(id: 'BIKE_001', status: BikeStatus.available),
    Bike(id: 'BIKE_002', status: BikeStatus.inUse),
    Bike(id: 'BIKE_003', status: BikeStatus.available),
    Bike(id: 'BIKE_004', status: BikeStatus.maintenance),
    Bike(id: 'BIKE_005', status: BikeStatus.available),
    Bike(id: 'BIKE_006', status: BikeStatus.available),
    Bike(id: 'BIKE_007', status: BikeStatus.inUse),
    Bike(id: 'BIKE_008', status: BikeStatus.available),
  ];

  @override
  Future<List<Bike>> fetchBikesByIds(List<String> ids) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => _bikes.where((bike) => ids.contains(bike.id)).toList(),
    );
  }
} 
