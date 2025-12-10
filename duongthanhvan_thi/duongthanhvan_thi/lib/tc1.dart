import 'package:flutter/material.dart';
import 'package:vanduong_thi/tcmoi.dart';

import 'classroom.dart';
import 'dshang.dart';
import 'giohang.dart';
import 'meet.dart';
import 'shop.dart';
import 'tcchinh.dart';
import 'vitri.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  final PageController _pageController = PageController(); // PageView controller

  // List of pages to display in PageView
  final List<Widget> _pages = [
    MyHomePage(),
    MyClassroom(),
    const MyProductList(),
    const MyShoppingCart(),
    MyPlace(),
    const MyShop(),
    MyMeeting(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trang Chủ',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 219, 219, 219),
        elevation: 4.0,
        centerTitle: true,
        toolbarHeight: 120,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
  radius: 40,
  backgroundColor: Colors.white,
  child: ClipOval(
    child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtaEHknbj_ADPu4v5vtw9EN2iThoLMGv7t9g&s', 
              fit: BoxFit.cover, 
              width: 80, 
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.error, 
                  size: 40, 
                  color: Colors.red, 
                );
              },
            ),
          ),
),
                ],
              ),
            ),
            _buildDrawerItem(Icons.home, 'Mainpage', 0),
            _buildDrawerItem(Icons.class_, 'Classroom', 1),
            _buildDrawerItem(Icons.add_shopping_cart_rounded, 'Product List', 2),
            _buildDrawerItem(Icons.shopping_cart, 'Shopping Cart', 3),
            _buildDrawerItem(Icons.place, 'Place', 4),
            _buildDrawerItem(Icons.shopping_bag, 'Shop', 5),
            _buildDrawerItem(Icons.meeting_room_sharp, 'Meeting', 6),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewPage()),
          );
        },
        backgroundColor: Colors.grey,
        child: Icon(Icons.add),
      ),
    );
  }

  // Helper function to build drawer items
  Widget _buildDrawerItem(IconData icon, String label, int index) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      onTap: () {
        _pageController.jumpToPage(index);
        Navigator.pop(context);
      },
    );
  }
}
