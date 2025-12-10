import 'dart:async';
import 'package:flutter/material.dart';

class TimerCountdownScreen extends StatefulWidget {
  const TimerCountdownScreen({super.key});

  @override
  State<TimerCountdownScreen> createState() => _TimerCountdownScreenState();
}

class _TimerCountdownScreenState extends State<TimerCountdownScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _timer;

  int _totalSeconds = 0;
  int _remainingSeconds = 0;

  bool get isRunning => _timer != null && _timer!.isActive;

  void _startTimer() {
    if (_controller.text.isEmpty) return;

    final int input = int.tryParse(_controller.text) ?? 0;
    if (input <= 0) return;

    setState(() {
      _totalSeconds = input;
      _remainingSeconds = input;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        t.cancel();
        setState(() {});
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = 0;
    });
  }

  String _formatTime(int seconds) {
    final int m = seconds ~/ 60;
    final int s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF42A5F5),
        elevation: 0,
        title: const Text(
          '⏳ Bộ đếm thời gian',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Nhập số giây cần đếm:',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),

                // Ô nhập số giây
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "30",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Hiển thị đếm thời gian
                Text(
                  _formatTime(_remainingSeconds),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 40),

                // Các nút điều khiển
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Nút Bắt Đầu
                    ElevatedButton(
                      onPressed: isRunning ? null : _startTimer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isRunning ? Colors.grey.shade300 : Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        "Bắt đầu",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Nút Reset
                    ElevatedButton(
                      onPressed: isRunning ? null : _resetTimer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isRunning ? Colors.grey.shade400 : Colors.grey,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        "Đặt lại",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
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
