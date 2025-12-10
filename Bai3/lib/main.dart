import 'package:flutter/material.dart';
import 'screens/travel_home_screen.dart'; // import màn mới

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const TravelHomeScreen(), // Home là màn hình TravelHome
    );
  }
}
