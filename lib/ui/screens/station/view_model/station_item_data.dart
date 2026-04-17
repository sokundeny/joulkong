import 'package:joulkong/model/bike.dart';
import 'package:joulkong/model/dock.dart';

class StationItemData {
  final Dock dock;
  final Bike? bike;

  StationItemData({
    required this.dock,
    required this.bike
  });
}
