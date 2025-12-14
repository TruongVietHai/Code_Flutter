import 'package:flutter/material.dart';

// Mainpage
import 'screens/mainpage_screen.dart';

// Bài 1 - 3
import 'screens/bai1_classroom_screen.dart';
import 'screens/bai3_color_timer_screen.dart';
import 'screens/color_changer_screen.dart';
import 'screens/counter_screen.dart';
import 'screens/timer_countdown_screen.dart';

// Bài 2 - Hotel List
import 'screens/bai2_hotel_list_file_screen.dart';

// Bài 4
import 'screens/bai4_auth_menu_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/profile_screen.dart';

// Bài 5
import 'screens/bai5_product_screen.dart';

// Bài 6 - News
import 'screens/bai6_news_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '22T1020593_TruongVietHai',
      debugShowCheckedModeBanner: false,

      initialRoute: '/mainpage',

      routes: {
        '/mainpage': (context) => const MainPageScreen(),

        // Bài 1 - 3
        '/bai1': (context) => const Bai1ClassroomScreen(),
        '/hotel_list_file': (context) => const Bai2HotelListFileScreen(),
        '/bai3': (context) => const Bai3ColorTimerScreen(),
        '/color': (context) => const ColorChangerScreen(),
        '/counter': (context) => const CounterScreen(),
        '/timer': (context) => const TimerCountdownScreen(),

        // Bài 4
        '/auth': (context) => const Bai4AuthMenuScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/profile': (context) => const ProfileScreen(email: 'demo@example.com'),

        // Bài 5
        '/products': (context) => const Bai5ProductScreen(),

        // Bài 6 (KHÔNG const!)
        '/news_list': (context) => Bai6NewsListScreen(),
      },
    );
  }
}
