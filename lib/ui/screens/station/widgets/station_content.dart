import 'package:flutter/material.dart';
import 'package:joulkong/model/dock.dart';
import 'package:joulkong/ui/screens/booking/booking_screen.dart';
import 'package:joulkong/ui/screens/station/view_model/station_item_data.dart';
import 'package:joulkong/ui/screens/station/view_model/station_view_model.dart';
import 'package:joulkong/ui/screens/station/widgets/dock_card.dart';
import 'package:joulkong/ui/utils/async_value.dart';
import 'package:provider/provider.dart';

class StationContent extends StatelessWidget {
  const StationContent({super.key});

  void _unlockDock(BuildContext context, Dock dock) {
    if (dock.bikeId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Dock ${dock.number} is empty")));
      return;
    }

    if (dock.isLocked) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Bike is locked for maintenance")));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Unlocking ${dock.bikeId} at Dock ${dock.number}'),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingScreen(
          dock: dock,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    StationViewModel mv = context.watch<StationViewModel>();
    AsyncValue<List<StationItemData>> asyncValue = mv.data;
    Widget content = const Center(child: Text('No State'));

    switch (asyncValue.state) {
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;

      case AsyncValueState.error:
        content = Center(
          child: Text(
            'error = ${asyncValue.error!}',
            style: TextStyle(color: Colors.red),
          ),
        );
        break;

      case AsyncValueState.success:
        List<StationItemData> docks = asyncValue.data!;
        int totalDocks = docks.length;
        int bikesCount = docks.where((d) => d.dock.bikeId != null).length;
        int availableDocks = totalDocks - bikesCount;
        double progress = totalDocks == 0 ? 0 : bikesCount / totalDocks;

        content = Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Container(
                width: double.infinity,
                color: Colors.grey[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mv.selectedStation.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // const SizedBox(height: 2),
                        Text(
                          'ID: ${mv.selectedStation.id}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Available Docks: $availableDocks',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned.fill(
                            child: CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 4,
                              strokeCap: StrokeCap.round,
                              backgroundColor: Colors.grey[300],
                            ),
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.pedal_bike, size: 20),
                              Text(
                                '$bikesCount',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dock Status',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Expanded(
                        child: GridView.builder(
                          itemCount: docks.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 0.8,
                              ),
                          itemBuilder: (context, index) {
                            final dock = docks[index];

                            return DockCard(
                              number: dock.dock.number,
                              bikeId: dock.dock.bikeId,
                              isLocked: dock.dock.isLocked,
                              onUnlock: () => _unlockDock(context, dock.dock),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Station Info')),
      body: content,
    );
  }
}
