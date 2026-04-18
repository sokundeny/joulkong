import 'package:flutter/material.dart';
import 'package:joulkong/data/repositories/subscribtions/subscription_repository.dart';
import 'package:joulkong/ui/screens/subscribtion/view_model/subscription_view_model.dart';
import 'package:joulkong/ui/screens/subscribtion/widgets/subscription_content.dart';
import 'package:joulkong/ui/state/app_state.dart';
import 'package:provider/provider.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> SubscriptionViewModel(
        subscribtionRepository: context.read<SubscriptionRepository>(),
        appState: context.read<AppState>()
      ),
      child: SubscriptionContent(),
    );
  }
}