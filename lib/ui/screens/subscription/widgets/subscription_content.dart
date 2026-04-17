import 'package:flutter/material.dart';
import 'package:joulkong/model/subscribtion.dart';
import 'subscription_card.dart';

class SubscriptionContent extends StatefulWidget {
  const SubscriptionContent({super.key});

  @override
  State<SubscriptionContent> createState() => _SubscriptionContentState();
}

class _SubscriptionContentState extends State<SubscriptionContent> {
  PassType? selected;

  final plans = [
    (PassType.single, 'Single Ride', '\$1.50', 'One-time ride'),
    (PassType.daily, 'Day Pass', '\$3.00', 'Unlimited for 24h'),
    (PassType.weekly, 'Weekly Pass', '\$10.00', 'Best for short trips'),
    (PassType.monthly, 'Monthly Pass', '\$30.00', 'Best value'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

      appBar: AppBar(
        title: const Text("Choose Subscription"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: Column(
        children: [
          const SizedBox(height: 16),

          /// HEADER
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get Your Pass ",
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  "Choose a plan that fits your ride",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: plans.length,
              itemBuilder: (context, index) {
                final p = plans[index];

                return SubscriptionCard(
                  title: p.$2,
                  price: p.$3,
                  description: p.$4,
                  isSelected: selected == p.$1,
                  onTap: () {
                    setState(() => selected = p.$1);
                  },
                );
              },
            ),
          ),

          /// BUTTON
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: selected == null
                  ? null
                  : () {
                      Navigator.pop(context, selected);
                    },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text("Continue"),
            ),
          ),
        ],
      ),
    );
  }
}