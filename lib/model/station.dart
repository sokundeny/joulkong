import 'package:joulkong/model/bike.dart';

class Station {
  final String id;
  final String name;
  final double latitute;
  final double longtitute;
  final List<Bike> bikes;

  Station({
    required this.id,
    required this.name,
    required this.latitute,
    required this.longtitute,
    this.bikes = const [],
  });

  List<Bike> get availableBikes =>
      bikes.where((b) => b.isAvailable).toList();

  int get availableBikeCount => availableBikes.length;
}