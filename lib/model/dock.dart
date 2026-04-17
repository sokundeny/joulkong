class Dock {
  final int number;
  final String stationId;
  final String? bikeId;
  final bool isLocked;

  Dock({required this.number, required this.stationId, this.bikeId, this.isLocked = false});

  DockStatus get status {
    if (isLocked) return DockStatus.locked;
    if (bikeId != null) return DockStatus.occupied;
    return DockStatus.available;
  }
}

enum DockStatus { available, occupied, locked }
