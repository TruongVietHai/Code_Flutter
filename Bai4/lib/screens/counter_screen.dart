import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _increase() {
    setState(() {
      _counter++;
    });
  }

  void _decrease() {
    setState(() {
      _counter--;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBFE), // nền hơi hồng nhạt
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Ứng dụng Đếm Số',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Giá trị hiện tại:',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '$_counter',
                  style: const TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Nút Giảm
                    ElevatedButton(
                      onPressed: _decrease,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE53935),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        '- Giảm',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Nút Đặt lại
                    ElevatedButton.icon(
                      onPressed: _reset,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB0BEC5),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text(
                        'Đặt lại',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Nút Tăng
                    ElevatedButton(
                      onPressed: _increase,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF43A047),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        '+ Tăng',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
