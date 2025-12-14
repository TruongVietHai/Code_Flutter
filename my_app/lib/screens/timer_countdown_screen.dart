import 'dart:async';
import 'package:flutter/material.dart';

class TimerCountdownScreen extends StatefulWidget {
  const TimerCountdownScreen({super.key});

  @override
  State<TimerCountdownScreen> createState() => _TimerCountdownScreenState();
}

class _TimerCountdownScreenState extends State<TimerCountdownScreen> {
  Timer? timer;
  int displaySeconds = 0;

  final hourController = TextEditingController();
  final minuteController = TextEditingController();
  final secondController = TextEditingController();

  int safeParse(String value) {
    if (value.isEmpty) return 0;
    final n = int.tryParse(value);
    return n ?? 0; // chống NaN
  }

  void startTimer() {
    timer?.cancel();

    int hours = safeParse(hourController.text);
    int minutes = safeParse(minuteController.text);
    int seconds = safeParse(secondController.text);

    int totalSeconds = hours * 3600 + minutes * 60 + seconds;

    if (totalSeconds <= 0) {
      setState(() => displaySeconds = 0);
      return;
    }

    setState(() {
      displaySeconds = totalSeconds;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (displaySeconds > 0) {
        setState(() => displaySeconds--);
      } else {
        t.cancel();
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      displaySeconds = 0;
      hourController.clear();
      minuteController.clear();
      secondController.clear();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    hourController.dispose();
    minuteController.dispose();
    secondController.dispose();
    super.dispose();
  }

  String formatTime(int seconds) {
    int h = seconds ~/ 3600;
    int m = (seconds % 3600) ~/ 60;
    int s = seconds % 60;

    return "${h.toString().padLeft(2, '0')} : "
           "${m.toString().padLeft(2, '0')} : "
           "${s.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đếm giờ"),
        leading: BackButton(
          onPressed: () => Navigator.pushReplacementNamed(context, '/mainpage'),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formatTime(displaySeconds),
                style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  timeInputField(hourController, "Giờ"),
                  const SizedBox(width: 10),
                  timeInputField(minuteController, "Phút"),
                  const SizedBox(width: 10),
                  timeInputField(secondController, "Giây"),
                ],
              ),

              const SizedBox(height: 30),

              ElevatedButton(onPressed: startTimer, child: const Text("Start")),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: stopTimer, child: const Text("Stop")),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: resetTimer, child: const Text("Reset")),
            ],
          ),
        ),
      ),
    );
  }

  Widget timeInputField(TextEditingController controller, String label) {
    return SizedBox(
      width: 70,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
