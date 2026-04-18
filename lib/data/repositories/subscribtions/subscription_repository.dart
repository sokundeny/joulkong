import 'package:joulkong/model/subscription.dart';

abstract class SubscriptionRepository {
  Future<List<Subscription>> fetchSubscribtion();
}
