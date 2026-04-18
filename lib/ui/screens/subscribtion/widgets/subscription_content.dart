import 'package:flutter/material.dart';
import 'package:joulkong/ui/screens/subscribtion/view_model/subscription_view_model.dart';
import 'package:joulkong/ui/screens/subscribtion/widgets/subscribtion_confirm_screen.dart';
import 'package:joulkong/ui/state/app_state.dart';
import 'package:joulkong/ui/widgets/primary_button.dart';
import 'package:joulkong/ui/widgets/subscription_card.dart';
import 'package:provider/provider.dart';
import 'package:joulkong/ui/utils/async_value.dart';

class SubscriptionContent extends StatelessWidget {
  const SubscriptionContent({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SubscriptionViewModel>().data;
    final appState = context.watch<AppState>();

    Widget content = const Center(child: Text("No state"));

    switch (state.state) {
      case AsyncValueState.loading:
        content = const Center(child: CircularProgressIndicator());
        break;

      case AsyncValueState.error:
        content = Center(
          child: Text(
            "Error: ${state.error}",
            style: const TextStyle(color: Colors.red),
          ),
        );
        break;

      case AsyncValueState.success:
        final subscriptions = state.data ?? [];

        content = ListView.builder(
          itemCount: subscriptions.length,
          itemBuilder: (context, index) {
            return SubscriptionCard(
              subscription: subscriptions[index],
              isSelected:
                  subscriptions[index].id ==
                  context.watch<SubscriptionViewModel>().selectedPlan,
              onClick: () {
                context.read<SubscriptionViewModel>().onClickSubscribtion(
                  subscriptions[index].id,
                );
              },
            );
          },
        );
        break;
    }

    if (appState.isSubscribed && appState.userSubscription != null) {
      final pass = appState.userSubscription!;

      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 36,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFF00E676).withOpacity(0.4),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(
                                    0xFF00E676,
                                  ).withOpacity(0.4),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 7,
                                    height: 7,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF00E676),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    'ACTIVE',
                                    style: TextStyle(
                                      color: Color(0xFF00E676),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: const Color(0xFF00E676).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.verified_rounded,
                                color: Color(0xFF00E676),
                                size: 24,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // Plan name
                        Text(
                          pass.subscription.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Membership Pass',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.3,
                          ),
                        ),

                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("• Unlimited bike rides"),
                            Text("• Access to all stations"),
                            Text("• No per-ride payment"),
                            Text("• Fast unlock with QR"),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Divider
                        Container(
                          height: 1,
                        ),

                        const SizedBox(height: 24),

                        // Expiry row
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_rounded,
                              size: 15,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Valid until',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              pass.expiryDate.toString(),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Buy PASS\nNow!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 24,
              ),
            ),
            Expanded(child: content),
            PrimaryButton(
              text: "Pay Now",
              onPressed: () {
                final vm = context.read<SubscriptionViewModel>();

                final selectedSub = vm.data.data!.firstWhere(
                  (e) => e.id == vm.selectedPlan,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SubscriptionConfirmScreen(
                      selected: selectedSub,
                      onBuyPass: () {
                        vm.onBuyPass();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
