import 'package:flutter/material.dart';
import 'package:joulkong/model/subscription.dart';
import 'package:joulkong/ui/widgets/primary_button.dart';

class SubscriptionConfirmScreen extends StatelessWidget {
  final Subscription selected;
  final VoidCallback onBuyPass;

  const SubscriptionConfirmScreen({super.key, required this.selected, required this.onBuyPass});

  String getPeriodText(int days) {
    if (days == 1) return "1 Day Pass";
    if (days == 30) return "1 Month Pass";
    if (days == 365) return "1 Year Pass";
    return "$days Days Pass";
  }

  String getPricePerDay() {
    final perDay = selected.price / selected.durationDays;
    return perDay.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Confirm Pass"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🧾 Header
            Text(
              "Review your pass",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Pass Name
                  Text(
                    selected.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Validity"),
                      Text(getPeriodText(selected.durationDays)),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Price"),
                      Text(
                        "\$${selected.price}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Cost per Day"),
                      Text("\$${getPricePerDay()}"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "What you get",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("• Unlimited bike rides"),
                Text("• Access to all stations"),
                Text("• No per-ride payment"),
                Text("• Fast unlock with QR"),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "*Your pass will be activated immediately after payment.",
                style: TextStyle(fontSize: 13),
              ),
            ),

            const Spacer(),

            PrimaryButton(
              text: "Confirm & Activate Pass",
              onPressed: onBuyPass,
            ),
          ],
        ),
      ),
    );
  }
}
