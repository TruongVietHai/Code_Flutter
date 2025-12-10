import 'dart:math';
import 'package:flutter/material.dart';

// Model đơn giản chứa màu và tên màu
class NamedColor {
  final Color color;
  final String name;

  NamedColor(this.color, this.name);
}

// Danh sách màu + tên tương ứng
final List<NamedColor> namedColors = [
  NamedColor(Colors.purple, 'Tím'),
  NamedColor(Colors.red, 'Đỏ'),
  NamedColor(Colors.blue, 'Xanh dương'),
  NamedColor(Colors.green, 'Xanh lá'),
  NamedColor(Colors.orange, 'Cam'),
  NamedColor(Colors.pink, 'Hồng'),
  NamedColor(Colors.teal, 'Xanh ngọc'),
];

class ColorChangerScreen extends StatefulWidget {
  const ColorChangerScreen({super.key});

  @override
  State<ColorChangerScreen> createState() => _ColorChangerScreenState();
}

class _ColorChangerScreenState extends State<ColorChangerScreen> {
  // index của màu hiện tại trong danh sách
  int _currentIndex = 0;

  final Random _random = Random();

  NamedColor get _currentNamedColor => namedColors[_currentIndex];

  void _changeColor() {
    setState(() {
      int newIndex;
      do {
        newIndex = _random.nextInt(namedColors.length);
      } while (newIndex == _currentIndex); // tránh trùng màu hiện tại
      _currentIndex = newIndex;
    });
  }

  void _resetColor() {
    setState(() {
      _currentIndex = 0; // đưa về màu đầu tiên (Tím)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // nền là màu hiện tại
      backgroundColor: _currentNamedColor.color,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // (tuỳ) chấm nhỏ ở giữa giống hình
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 40),

              const Text(
                'Màu hiện tại',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                _currentNamedColor.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nút Đổi màu
                  ElevatedButton.icon(
                    onPressed: _changeColor,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(Icons.palette),
                    label: const Text(
                      'Đổi màu',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Nút Đặt lại
                  ElevatedButton.icon(
                    onPressed: _resetColor,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text(
                      'Đặt lại',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
