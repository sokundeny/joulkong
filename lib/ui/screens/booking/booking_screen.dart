import 'package:flutter/material.dart';
import 'package:joulkong/model/dock.dart';
import 'package:joulkong/ui/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:joulkong/ui/screens/booking/view_model/booking_view_model.dart';
import 'package:joulkong/ui/screens/booking/widgets/booking_content.dart';

class BookingScreen extends StatelessWidget {
  final Dock dock;

  const BookingScreen({super.key, required this.dock,});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingViewModel(
        appState: context.read<AppState>(),
        dock: dock,
      ),
      child: BookingContent(),
    );
  }
}
