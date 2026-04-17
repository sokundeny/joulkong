import 'package:flutter/material.dart';
import 'package:joulkong/ui/screens/booking/view_model/booking_view_model.dart';

class BikeList extends StatelessWidget {
  final BookingViewModel vm;

  const BikeList({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    final bikes = vm.availableBikes;

      if (bikes.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.pedal_bike_outlined,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 12),
              Text(
                "No bikes available",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "Please check again later",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: bikes.map((bike) {
        return GestureDetector(
          onTap: vm.canBook ? () => vm.bookBike(bike.id) : null,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.directions_bike),
                const SizedBox(height: 4),
                Text(bike.id, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}