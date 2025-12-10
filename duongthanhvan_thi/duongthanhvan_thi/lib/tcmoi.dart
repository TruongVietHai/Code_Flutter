import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trang Mới')),
      body: const Center(
        child: Text('Chào mừng đến với trang mới!'),
      ),
    );
  }
}
