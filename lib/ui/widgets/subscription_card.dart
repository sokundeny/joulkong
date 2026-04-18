import 'package:flutter/material.dart';
import 'package:joulkong/model/subscription.dart';

class SubscriptionCard extends StatelessWidget {
  final Subscription subscription;
  final bool isSelected;
  final VoidCallback onClick;

  const SubscriptionCard({
    super.key,
    required this.subscription,
    required this.isSelected,
    required this.onClick
  });

  String getPeriodText(int days) {
    if (days == 1) return "1 Day";
    if (days == 30) return "1 Month";
    if (days == 365) return "1 Year";
    return "$days Days";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color:isSelected?Theme.of(context).colorScheme.secondary: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: onClick,
        isThreeLine: true,

        title: Text(
          subscription.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Period: ${getPeriodText(subscription.durationDays)}"),
            Text("\$${subscription.price}"),
          ],
        ),
        trailing: Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey
            ),
            borderRadius: BorderRadius.circular(999)
          ),
          child: Center(
              child: Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                color: isSelected?Theme.of(context).colorScheme.secondary:Colors.transparent,
                borderRadius: BorderRadius.circular(999)
              ),
            ),
          )
        ),
      ),
    );
  }
}
