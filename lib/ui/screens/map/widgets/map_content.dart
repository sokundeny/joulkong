import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:joulkong/ui/screens/map/view_model/map_data.dart';
import 'package:joulkong/ui/screens/map/view_model/map_view_model.dart';
import 'package:joulkong/ui/screens/map/widgets/station_marker.dart';
import 'package:joulkong/ui/screens/map/widgets/station_preview_sheet.dart';
import 'package:joulkong/ui/utils/async_value.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapContent extends StatelessWidget {
  const MapContent({super.key});

  final String API_KEY = '';
  @override
  Widget build(BuildContext context) {
    MapViewModel mv = context.watch<MapViewModel>();
    AsyncValue<List<MapData>> asyncValue = mv.data;
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
        List<MapData> stationData = asyncValue.data!;

        final markers = stationData.asMap().entries.map((entry) {
          final data = entry.value;

          return Marker(
            point: LatLng(data.station.latitute, data.station.longtitute),
            width: 50,
            height: 70,
            child: StationMarker(
              number: data.bikes,
              onTap: () {
                debugPrint('Tapped: ${data.station.name}');

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return StationPreviewSheet(
                      station: data.station,
                      totalDocks: data.docks,
                      totalBikes: data.bikes,
                    );
                  },
                );
                // Navigator.of(context).push(
                //   AnimationUtils.createRightToLeftRoute(
                //     StationScreen(selectedStation: station),
                //   ),
                // );
              },
            ),
          );
        }).toList();

        content = FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(11.5564, 104.9282),
            initialZoom: 16,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}.png?api_key=$API_KEY',
              userAgentPackageName: 'JoulKongApp',
            ),

            MarkerLayer(markers: markers),
          ],
        );
        break;
    }

    return Scaffold(body: content);
  }
}
