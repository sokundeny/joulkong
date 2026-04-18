import 'package:flutter/material.dart';
import 'package:joulkong/model/subscribtion.dart';
import 'package:joulkong/ui/screens/booking/view_model/booking_view_model.dart';
import 'package:joulkong/ui/screens/subscription/subscription_screen.dart';

class PassSelection extends StatelessWidget {
  final BookingViewModel vm;

  const PassSelection({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    final passes = [
      (PassType.single, 'Single Ride', '\$1.50'),
      (PassType.daily, 'Day Pass', '\$3.00'),
      (PassType.weekly, 'Week Pass', '\$10.00'),
      (PassType.monthly, 'Month Pass', '\$30.00'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Choose a Pass",
            style: TextStyle(fontWeight: FontWeight.bold)),

        const SizedBox(height: 12),

        ...passes.map((p) {
          return GestureDetector(
          onTap: () async {
            final selected = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SubscriptionScreen(),
              ),
            );

            if (selected != null) {
              vm.purchasePass(selected);
            }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              children: [
                const Icon(Icons.card_membership, color: Colors.blue),
                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    p.$2,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),

                Text(
                  p.$3,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
        }),
      ],
    );
  }
}