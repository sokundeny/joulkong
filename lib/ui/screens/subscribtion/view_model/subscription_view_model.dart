import 'package:flutter/widgets.dart';
import 'package:joulkong/data/repositories/subscribtions/subscription_repository.dart';
import 'package:joulkong/model/subscription.dart';
import 'package:joulkong/model/user_subscription.dart';
import 'package:joulkong/ui/state/app_state.dart';
import 'package:joulkong/ui/utils/async_value.dart';

class SubscriptionViewModel extends ChangeNotifier {
  final SubscriptionRepository subscribtionRepository;
  final AppState appState;

  AsyncValue<List<Subscription>> data = AsyncValue.loading();

  int selectedPlan = 1;

  SubscriptionViewModel({
    required this.subscribtionRepository,
    required this.appState,
  }) {
    fetchSubscribtion();
  }

  Future<void> fetchSubscribtion() async {
    data = AsyncValue.loading();
    notifyListeners();

    try {
      final subscription = await subscribtionRepository.fetchSubscribtion();
      data = AsyncValue.success(subscription);
    } catch (e) {
      data = AsyncValue.error(e.toString());
    }

    notifyListeners();
  }

  void onClickSubscribtion(int id) {
    selectedPlan = id;
    notifyListeners();
  }

  void onBuyPass() {
    final subscriptionList = data.data;

    if (subscriptionList == null) return;

    final selected = subscriptionList.firstWhere((e) => e.id == selectedPlan);

    final now = DateTime.now();

    final expiry = now.add(Duration(days: selected.durationDays));

    final userSubscription = UserSubscription(
      subscription: selected,
      purchaseDate: now,
      expiryDate: expiry,
    );

    appState.setUserSubscription(userSubscription);

    notifyListeners();
  }
}
