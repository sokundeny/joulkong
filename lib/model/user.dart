import 'package:joulkong/model/subscribtion.dart';

class User {
  final String id;
  final String name;
  final String email;
  final Subscription? activeSubscription;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.activeSubscription,
  });

  bool get hasActivePass =>
      activeSubscription != null && activeSubscription!.isActive;
}