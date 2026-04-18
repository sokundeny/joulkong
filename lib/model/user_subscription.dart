import 'package:joulkong/model/subscription.dart';

class UserSubscription {
  final DateTime purchaseDate;
  final DateTime expiryDate;
  final Subscription subscription;

  UserSubscription({
    required this.purchaseDate,
    required this.expiryDate,
    required this.subscription,
  });

  bool get isActive {
    return DateTime.now().isBefore(expiryDate);
  }
}
