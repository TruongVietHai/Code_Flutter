import 'package:flutter/material.dart';
import 'screens/hotel_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Danh sách khách sạn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      // Home chính của app là màn hình danh sách khách sạn
      home: const HotelListScreen(),
    );
  }
}
