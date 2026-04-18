enum BikeStatus { available, booked, inUse, maintenance }

class Bike {
  final String id;
  BikeStatus status;

  Bike({required this.id, this.status = BikeStatus.available});

  bool get isAvailable => status == BikeStatus.available;
}