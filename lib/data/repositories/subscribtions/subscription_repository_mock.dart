import 'package:joulkong/data/repositories/subscribtions/subscription_repository.dart';
import 'package:joulkong/model/subscription.dart';

class SubscriptionRepositoryMock implements SubscriptionRepository {

  List<Subscription> subscriptions = [
    Subscription(id: 3, name: "Daily Pass", price: 2, durationDays: 1),
    Subscription(id: 2, name: "Monthly Pass", price: 10, durationDays: 30),
    Subscription(id: 1, name: "Annual Pass", price: 108, durationDays: 365),
  ];

  @override
  Future<List<Subscription>> fetchSubscribtion() async{
    return Future.delayed(Duration(seconds: 0), () {
      return subscriptions;
    });
  }
}
