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
    String title = mv.selectedStation.name;

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
        title = mv.selectedStation.name;

        content = Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dock Status',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: GridView.builder(
                  itemCount: docks.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9,
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
        );
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: content,
    );
  }
}
