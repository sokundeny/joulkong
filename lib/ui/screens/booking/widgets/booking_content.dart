import 'package:flutter/material.dart';
import 'package:joulkong/ui/screens/booking/widgets/booking_success.dart';
import 'package:joulkong/ui/screens/subscribtion/subscription_screen.dart';
import 'package:joulkong/ui/widgets/primary_button.dart';
import 'package:joulkong/ui/widgets/secondary_button.dart';
import 'package:provider/provider.dart';
import 'package:joulkong/ui/screens/booking/view_model/booking_view_model.dart';

class BookingContent extends StatefulWidget {
  const BookingContent({super.key});

  @override
  State<BookingContent> createState() => _BookingContentState();
}

class _BookingContentState extends State<BookingContent> {
  bool _isBuyingTicket = false;
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BookingViewModel>();
    final dock = vm.dock;
    final bikeId = dock.bikeId;
    if (_isBuyingTicket) {
      return _DayPassConfirmScreen(
        onBuyPass: () {
          vm.bookBike(bikeId!);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BookingSuccess(vm: vm)),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Dock #${dock.number}')),
      body: Center(
        child: Text(
          bikeId != null ? 'Bike: $bikeId' : 'No bike docked',
          style: const TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: vm.appState.isSubscribed
            ? PrimaryButton(
                text: "Book",
                onPressed: () {
                  vm.bookBike(bikeId!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => BookingSuccess(vm: vm)),
                  );
                },
              )
            : Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      onPressed: () {
                        setState(() {
                          _isBuyingTicket = true;
                        });
                      },
                      text: 'Buy Ticket',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PrimaryButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SubscriptionScreen(isTemp: true),
                          ),
                        );
                        // triggers rebuild when returning from SubscriptionScreen
                        setState(() {});
                      },
                      text: 'Buy Pass',
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _DayPassConfirmScreen extends StatelessWidget {
  final VoidCallback onBuyPass;

  const _DayPassConfirmScreen({super.key, required this.onBuyPass});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Confirm Pass"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🧾 Header
            Text(
              "Review your pass",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Pass Name
                  Text(
                    "1 Journey Pass",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [const Text("Validity"), Text("1 Journey")],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Price"),
                      Text(
                        "1",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "What you get",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("• limited bike rides"),
                Text("• per-ride payment"),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "*Your can be used immediately after payment.",
                style: TextStyle(fontSize: 13),
              ),
            ),

            const Spacer(),

            PrimaryButton(text: "Confirm Ticket", onPressed: onBuyPass),
          ],
        ),
      ),
    );
  }
}
