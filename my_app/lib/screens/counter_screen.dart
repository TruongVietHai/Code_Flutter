import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int count = 0;

  void increase() => setState(() => count++);
  void decrease() => setState(() => count--);
  void reset() => setState(() => count = 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bộ đếm số",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pushReplacementNamed(context, '/bai3'),
        ),
      ),
      extendBodyBehindAppBar: true,

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🔥 Số đếm lớn với hiệu ứng
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: Text(
                    '$count',
                    key: ValueKey<int>(count),
                    style: const TextStyle(
                      fontSize: 120,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 4),
                          blurRadius: 10,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔥 Status text
                Text(
                  count == 0
                      ? "Bắt đầu nào!"
                      : count > 0
                          ? "Tuyệt vời! Tiếp tục nhé"
                          : "Ồ, đã về âm rồi à?",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 80),

                // 🔥 3 nút hành động
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Giảm
                    FloatingActionButton.large(
                      heroTag: "decrease",
                      backgroundColor: Colors.white.withOpacity(0.25),
                      foregroundColor: Colors.white,
                      elevation: 8,
                      onPressed: decrease,
                      child: const Icon(Icons.remove, size: 36),
                    ),

                    const SizedBox(width: 30),

                    // Reset
                    FloatingActionButton.extended(
                      heroTag: "reset",
                      backgroundColor: Colors.orange.shade400,
                      foregroundColor: Colors.white,
                      elevation: 10,
                      icon: const Icon(Icons.refresh),
                      label: const Text(
                        "Đặt lại",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onPressed: reset,
                    ),

                    const SizedBox(width: 30),

                    // Tăng
                    FloatingActionButton.large(
                      heroTag: "increase",
                      backgroundColor: Colors.white.withOpacity(0.25),
                      foregroundColor: Colors.white,
                      elevation: 8,
                      onPressed: increase,
                      child: const Icon(Icons.add, size: 36),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // 🔥 NÚT QUAY VỀ BÀI 3
                OutlinedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: const Text(
                    "Quay về Bài 3",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 14),
                    side: const BorderSide(color: Colors.white, width: 2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/bai3'),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
