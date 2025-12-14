import 'package:flutter/material.dart';

class Bai3ColorTimerScreen extends StatefulWidget {
  const Bai3ColorTimerScreen({super.key});

  @override
  State<Bai3ColorTimerScreen> createState() => _Bai3ColorTimerScreenState();
}

class _Bai3ColorTimerScreenState extends State<Bai3ColorTimerScreen> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Bài 3 - Color & Timer"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.7), Colors.transparent],
            ),
          ),
        ),
      ),

      body: Stack(
        children: [
          // Ảnh nền
          Positioned.fill(
            child: Image.network(
              "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=1600&q=80",
              fit: BoxFit.cover,
            ),
          ),

          // Lớp mờ gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),

          // Nút Home
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            child: FloatingActionButton(
              mini: true,
              heroTag: "home_bai3",
              backgroundColor: Colors.white.withOpacity(0.95),
              elevation: 8,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/mainpage', (route) => false);
              },
              child: const Icon(Icons.home_rounded, color: Colors.deepPurple, size: 28),
            ),
          ),

          // Nội dung chính - ĐÃ KHẮC PHỤC HOÀN TOÀN LỖI OVERFLOW
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 80, 20, 30), // Đã tối ưu
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 
                              MediaQuery.of(context).padding.top - 
                              kToolbarHeight - 100,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Tiêu đề
                      const Text(
                        "Chọn chức năng",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                          height: 1.3,
                          shadows: [
                            Shadow(
                              color: Colors.black87,
                              blurRadius: 15,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 50),

                      // 3 item menu - đã thu nhỏ hợp lý
                      _animatedMenuItem(
                        context,
                        index: 0,
                        isHovered: _hoveredIndex == 0,
                        title: "Đổi màu nền",
                        icon: Icons.palette,
                        color: Colors.pinkAccent,
                        route: "/color",
                      ),
                      const SizedBox(height: 18),

                      _animatedMenuItem(
                        context,
                        index: 1,
                        isHovered: _hoveredIndex == 1,
                        title: "Bộ đếm số",
                        icon: Icons.calculate,
                        color: Colors.cyan,
                        route: "/counter",
                      ),
                      const SizedBox(height: 18),

                      _animatedMenuItem(
                        context,
                        index: 2,
                        isHovered: _hoveredIndex == 2,
                        title: "Đếm ngược thời gian",
                        icon: Icons.timer,
                        color: Colors.amber,
                        route: "/timer",
                      ),

                      const SizedBox(height: 40), // Đệm dưới để không sát đáy
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _animatedMenuItem(
    BuildContext context, {
    required int index,
    required bool isHovered,
    required String title,
    required IconData icon,
    required Color color,
    required String route,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..scale(isHovered ? 1.04 : 1.0),
        transformAlignment: Alignment.center,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => Navigator.pushNamed(context, route),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: isHovered
                    ? Colors.white.withOpacity(0.28)
                    : Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isHovered ? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(0.3),
                  width: isHovered ? 2 : 1.5,
                ),
                boxShadow: isHovered
                    ? [
                        BoxShadow(
                          color: color.withOpacity(0.7),
                          blurRadius: 25,
                          spreadRadius: 3,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(isHovered ? 0.9 : 0.6),
                          blurRadius: isHovered ? 18 : 10,
                        ),
                      ],
                    ),
                    child: Icon(icon, size: 30, color: Colors.white),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: isHovered ? FontWeight.bold : FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white.withOpacity(isHovered ? 1.0 : 0.7),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}