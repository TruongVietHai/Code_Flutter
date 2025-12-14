import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      child: Drawer(
        elevation: 14,
        shadowColor: Colors.black.withOpacity(0.25),

        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.grey.shade100,
                Colors.grey.shade200,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(),

              const SizedBox(height: 6),
              _hoverItem(context, Icons.home, "Mainpage", "/mainpage"),
              _hoverItem(context, Icons.class_, "Bài 1 - Classroom", "/bai1"),
              _hoverItem(context, Icons.hotel, "Bài 2 - Hotel List", "/hotel_list_file"),
              _hoverItem(context, Icons.color_lens, "Bài 3 - Color & Timer", "/bai3"),
              _hoverItem(context, Icons.lock_open, "Bài 4 - Login & Register", "/auth"),
              _hoverItem(context, Icons.shopping_bag, "Bài 5 - Product", "/products"),
              _hoverItem(context, Icons.newspaper, "Bài 6 - News List", "/news_list"),
            ],
          ),
        ),
      ),
    );
  }

  /// ⭐ HEADER TRÒN + CHUYÊN NGHIỆP
  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade700,
            Colors.blue.shade500,
            Colors.blue.shade300,
          ],
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(30),
          topLeft: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white.withOpacity(0.9),
            child: const Icon(Icons.school, size: 34, color: Colors.blue),
          ),
          const SizedBox(width: 14),
          const Text(
            "Truong Viet Hai",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  /// ⭐ ITEM CÓ HIỆU ỨNG HOVER MƯỢT – BO TRÒN ĐẸP
  Widget _hoverItem(
      BuildContext context, IconData icon, String title, String route) {
    bool isHover = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHover = true),
          onExit: (_) => setState(() => isHover = false),

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            transform: Matrix4.identity()..scale(isHover ? 1.05 : 1.0),

            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 10),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28), // BO TRÒN NHIỀU HƠN
              color: isHover ? Colors.blue.withOpacity(0.12) : Colors.transparent,

              boxShadow: isHover
                  ? [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.28),
                        blurRadius: 16,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : [],
            ),

            child: ListTile(
              leading: Icon(
                icon,
                size: 26,
                color: isHover ? Colors.blue.shade700 : Colors.black87,
              ),

              title: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: isHover ? 18 : 16,
                  fontWeight: isHover ? FontWeight.bold : FontWeight.normal,
                  color: isHover ? Colors.blue.shade700 : Colors.black87,
                ),
                child: Text(title),
              ),

              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, route);
              },
            ),
          ),
        );
      },
    );
  }
}
