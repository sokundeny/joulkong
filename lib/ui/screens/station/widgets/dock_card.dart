import 'package:flutter/material.dart';
import 'package:joulkong/ui/theme/theme.dart';

class DockCard extends StatelessWidget {
  final int number;
  final String? bikeId;
  final bool isLocked;
  final VoidCallback? onUnlock;

  const DockCard({
    super.key,
    required this.number,
    required this.bikeId,
    required this.isLocked,
    this.onUnlock,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasBike = bikeId != null;
    final bool isAvailable = hasBike && !isLocked;

    Color color;
    String status;

    if (isLocked) {
      color = Colors.red;
      status = "Locked";
    } else if (hasBike) {
      color = AppTheme.secondaryColor;
      status = "Available";
    } else {
      color = Colors.grey;
      status = "Empty";
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Dock $number',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isAvailable ? Colors.black : Colors.grey,
            ),
          ),

          Column(
            children: [
              Icon(
                Icons.pedal_bike,
                color: isAvailable ? AppTheme.secondaryColor : Colors.grey,
                size: 30,
              ),
              const SizedBox(height: 6),
              Text(status, style: TextStyle(color: color)),
              if (hasBike)
                Text(
                  bikeId!,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
            ],
          ),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isAvailable ? onUnlock : null,
              child: const Text("Unlock"),
            ),
          ),
        ],
      ),
    );
  }
}
