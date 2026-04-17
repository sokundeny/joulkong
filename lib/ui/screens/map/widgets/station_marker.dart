import 'package:flutter/material.dart';

class StationMarker extends StatelessWidget {
  final int number;
  final VoidCallback? onTap;
  final Color color;

  const StationMarker({
    super.key,
    required this.number,
    this.onTap,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: Colors.black, size: 25),
        ],
      ),
    );
  }
}
