enum PassType { single, daily, weekly, monthly }

class Subscription {
  final PassType type;
  final double price;
  final DateTime expiresAt;

  Subscription({
    required this.type,
    required this.price,
    required this.expiresAt,
  });

  bool get isActive => expiresAt.isAfter(DateTime.now());

  String get label {
    switch (type) {
      case PassType.single:
        return 'Single Ticket';
      case PassType.daily:
        return 'Day Pass';
      case PassType.weekly:
        return 'Week Pass';
      case PassType.monthly:
        return 'Month Pass';
    }
  }

  double get priceForType {
    switch (type) {
      case PassType.single:
        return 1.50;
      case PassType.daily:
        return 3.00;
      case PassType.weekly:
        return 10.00;
      case PassType.monthly:
        return 30.00;
    }
  }
}