/*import 'package:flutter/material.dart';
import 'screens/color_changer_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Đổi màu nền',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const ColorChangerScreen(), // Màn hình chính
    );
  }
}*/


/*import 'package:flutter/material.dart';
import 'screens/counter_screen.dart'; // import màn đếm số

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng dụng Đếm Số',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const CounterScreen(), // HOME = màn đếm số
    );
  }
}*/


import 'package:flutter/material.dart';
import 'screens/timer_countdown_screen.dart';  // nhớ đúng đường dẫn & tên file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bộ đếm thời gian',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      // Màn hình chính của app
      home: const TimerCountdownScreen(),
    );
  }
}



