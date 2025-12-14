import 'package:flutter/material.dart';

class Bai4AuthMenuScreen extends StatelessWidget {
  const Bai4AuthMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: const Text(
          "Bài 4 - Authentication",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/mainpage');
          },
        ),
      ),

      body: Stack(
        children: [
          /// ẢNH NỀN
          Positioned.fill(
            child: Image.network(
              "https://images.unsplash.com/photo-1506765515384-028b60a970df?auto=format&fit=crop&w=1600&q=80",
              fit: BoxFit.cover,
            ),
          ),

          /// LỚP PHỦ GRADIENT PASTEL
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.pink.withOpacity(0.3),
                    Colors.blue.withOpacity(0.3),
                    Colors.purple.withOpacity(0.3),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          /// FORM MENU
          Center(
            child: Container(
              width: 350,
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Login & Register",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),

                 
                  const SizedBox(height: 30),

                  /// LOGIN BUTTON
                  _buildGlassButton(
                    context,
                    title: "Đăng nhập",
                    icon: Icons.login,
                    gradient: const [Colors.blueAccent, Colors.lightBlue],
                    route: '/login',
                  ),

                  const SizedBox(height: 18),

                  /// REGISTER BUTTON
                  _buildGlassButton(
                    context,
                    title: "Đăng ký",
                    icon: Icons.person_add,
                    gradient: const [Color.fromARGB(255, 169, 157, 161), Color.fromARGB(255, 146, 142, 147)],
                    route: '/register',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// CUSTOM BUTTON GLASS + GRADIENT
  Widget _buildGlassButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Color> gradient,
    required String route,
  }) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: gradient.last.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(width: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}
