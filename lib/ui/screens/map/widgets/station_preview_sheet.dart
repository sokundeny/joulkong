import 'package:flutter/material.dart';
import 'package:joulkong/model/station.dart';
import 'package:joulkong/ui/screens/station/station_screen.dart';
import 'package:joulkong/ui/theme/theme.dart';
import 'package:joulkong/ui/utils/animations_util.dart';

class StationPreviewSheet extends StatelessWidget {
  final Station station;
  final int totalDocks;
  final int totalBikes;
  final int currentIndex = 0;

  StationPreviewSheet({super.key, required this.station, required this.totalDocks, required this.totalBikes});

  final List<String> mockImages = [
    'https://picsum.photos/400/200?1',
    'https://picsum.photos/400/200?2',
    'https://picsum.photos/400/200?3',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 180,
            child: Stack(
              children: [
                Image.network(
                  mockImages[currentIndex],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),

                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black54],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 12,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Text(
                    station.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Row(
                    children: List.generate(mockImages.length, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: currentIndex == index ? 8 : 6,
                        height: currentIndex == index ? 8 : 6,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Colors.white
                              : Colors.white70,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: AppTheme.primaryColor),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Lat: ${station.latitute}, Lng: ${station.longtitute}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.directions_bike, color: AppTheme.primaryColor),
                    const SizedBox(width: 6),
                    Text('Bike: $totalBikes'),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.local_parking, color: AppTheme.primaryColor),
                    const SizedBox(width: 6),
                    Text('Dock: $totalDocks'),
                  ],
                ),

                SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);

                      Navigator.of(context).push(
                        AnimationUtils.createRightToLeftRoute(
                          StationScreen(selectedStation: station),
                        ),
                      );
                    },
                    child: const Text('View Details'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
