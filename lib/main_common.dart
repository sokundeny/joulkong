
import 'package:flutter/material.dart';
import 'package:joulkong/data/repositories/stations/station_repository.dart';
import 'package:joulkong/data/repositories/stations/station_repository_mock.dart';
import 'package:joulkong/data/repositories/user/user_repository.dart' show UserRepository;
import 'package:joulkong/data/repositories/user/user_repository_mock.dart';
import 'package:joulkong/ui/screens/map/map_screen.dart';
import 'package:joulkong/ui/screens/subscribtion/subscription_screen.dart';
import 'package:provider/provider.dart';
import 'package:joulkong/ui/theme/theme.dart';

void mainCommon(List<InheritedProvider> providers) {
  runApp(
    MultiProvider(
      providers: [
        Provider<StationRepository>(
          create: (_) => StationRepositoryMock(),
        ),
        Provider<UserRepository>(
          create: (_) => UserRepositoryMock(),
        ),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MapScreen(), SubscriptionScreen(), MapScreen()
  ];

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Joul Kong"),
          centerTitle: false,
        ),
        body: _pages[_currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
            BottomNavigationBarItem(icon: Icon(Icons.subscriptions), label: 'Pass'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          ],
        ),
      ),
    );
  }
}


