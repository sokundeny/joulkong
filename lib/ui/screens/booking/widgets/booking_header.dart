import 'package:flutter/material.dart';
import 'package:joulkong/model/station.dart';

class BookingHeader extends StatelessWidget {
  final Station station;

  const BookingHeader({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.pedal_bike, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                station.name,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "${station.availableBikeCount} bikes available",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}