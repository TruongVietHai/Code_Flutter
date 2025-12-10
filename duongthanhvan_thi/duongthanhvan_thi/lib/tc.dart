import 'package:flutter/material.dart';
import 'package:vanduong_thi/classroom.dart';
import 'package:vanduong_thi/dshang.dart';
import 'package:vanduong_thi/giohang.dart';
import 'package:vanduong_thi/meet.dart';
import 'package:vanduong_thi/shop.dart';
import 'package:vanduong_thi/tc1.dart';
import 'package:vanduong_thi/tcchinh.dart';
import 'package:vanduong_thi/vitri.dart';


void main() {
   runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyMainPage(), // Trang chính là MyMainPage
  ));
}

class MyWebApp extends StatelessWidget {
  const MyWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/classroom': (context) => MyClassroom(),
        '/place': (context) => MyPlace(),
        '/productlist': (context) => const MyProductList(),
        '/shop': (context) => const MyShop(),
        '/shoppingcart': (context) => const MyShoppingCart(),
        '/gmail':(context)=> MyMeeting()
      },
    );
  }
}
