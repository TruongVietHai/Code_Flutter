import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key});

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),

      appBar: AppBar(
        title: const Text(
          "______HOME______",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 203, 205, 206),
        centerTitle: true,
        elevation: 3,
      ),

      body: Stack(
        children: [
          // Ảnh nền
          Positioned.fill(
            child: Image.network(
              "https://images.unsplash.com/photo-1445019980597-93fa8acb246c?auto=format&fit=crop&w=1600&q=80",
              fit: BoxFit.cover,
            ),
          ),

          // Lớp mờ nền
          Container(
            color: Colors.black.withOpacity(0.4),
          ),

          // Nội dung chính + hover effect
          Center(
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),

              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                splashColor: Colors.white.withOpacity(0.3),
                highlightColor: Colors.transparent,

                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Chào mừng đến lớp 22T1020593!")),
                  );
                },

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// ⭐ Dòng chữ chính
                      Text(
                        "Classroom of 22T1020593",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                          letterSpacing: 1.2,
                          shadows: _isHovered
                              ? [
                                  const Shadow(
                                    color: Colors.white,
                                    blurRadius: 12,
                                    offset: Offset(0, 0),
                                  ),
                                  Shadow(
                                    color: Colors.white.withOpacity(0.6),
                                    blurRadius: 24,
                                    offset: const Offset(0, 0),
                                  ),
                                  const Shadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ]
                              : [
                                  const Shadow(
                                    color: Colors.black45,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// ⭐ Dòng chữ phụ thêm theo yêu cầu
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: _isHovered ? 1 : 0.85,

                        child: Text(
                          "Lập trình ứng dụng di động – Thầy Nguyễn Dũng",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.92),
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.45),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
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
}
