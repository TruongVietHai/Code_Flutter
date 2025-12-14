import 'dart:math';
import 'package:flutter/material.dart';

class ColorChangerScreen extends StatefulWidget {
  const ColorChangerScreen({super.key});

  @override
  State<ColorChangerScreen> createState() => _ColorChangerScreenState();
}

class _ColorChangerScreenState extends State<ColorChangerScreen> {
  // Danh sách màu & tên màu
  final List<Map<String, dynamic>> colors = [
    {"name": "Màu đỏ", "color": Colors.red},
    {"name": "Màu xanh", "color": Colors.blue},
    {"name": "Màu vàng", "color": Colors.yellow},
    {"name": "Màu cam", "color": Colors.orange},
    {"name": "Màu tím", "color": Colors.purple},
    {"name": "Màu đen", "color": Colors.black},
    {"name": "Màu hồng", "color": Colors.pink},
    {"name": "Màu xanh lá", "color": Colors.green},
  ];

  Color bgColor = Colors.white;
  String colorName = "Chưa chọn màu";

  void randomColor() {
    final random = Random();
    final index = random.nextInt(colors.length);

    setState(() {
      bgColor = colors[index]["color"];
      colorName = colors[index]["name"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("Đổi màu nền"),
        leading: BackButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/mainpage'),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              colorName,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: bgColor == Colors.yellow ||
                        bgColor == Colors.orange ||
                        bgColor == Colors.pink
                    ? Colors.black
                    : Colors.white,
              ),
            ),

            const SizedBox(height: 30),

            // Nút đổi màu
            ElevatedButton(
              onPressed: randomColor,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                "Đổi màu",
                style: TextStyle(fontSize: 18),
              ),
            ),

            const SizedBox(height: 20),

            // 🔥 NÚT QUAY VỀ BÀI 3
            OutlinedButton.icon(
              icon: const Icon(Icons.arrow_back),
              label: const Text(
                "Quay về Bài 3",
                style: TextStyle(fontSize: 16),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: bgColor == Colors.yellow ||
                          bgColor == Colors.orange ||
                          bgColor == Colors.pink
                      ? Colors.black
                      : Colors.white,
                  width: 2,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                foregroundColor:
                    bgColor == Colors.yellow ||
                            bgColor == Colors.orange ||
                            bgColor == Colors.pink
                        ? Colors.black
                        : Colors.white,
              ),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/bai3'),
            ),
          ],
        ),
      ),
    );
  }
}
