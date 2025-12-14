import 'package:flutter/material.dart';

class Bai2HotelListFileScreen extends StatefulWidget {
  const Bai2HotelListFileScreen({super.key});

  @override
  State<Bai2HotelListFileScreen> createState() => _Bai2HotelListFileScreenState();
}

class _Bai2HotelListFileScreenState extends State<Bai2HotelListFileScreen> {
  int? _hoveredIndex; // Theo dõi card đang hover

  // Ảnh đã được kiểm tra kỹ – không còn 404
  final hotels = [
    {
      "name": "aNhill Boutique",
      "rate": "9.5",
      "reviews": "95 đánh giá",
      "location": "Huế - Cách bạn 0.6km",
      "price": "US\$109",
      "image":
          "https://images.unsplash.com/photo-1568605114967-8130f3a36994?auto=format&fit=crop&w=800&q=80"
    },
    {
      "name": "Pilgrimage Village Boutique",
      "rate": "9.3",
      "reviews": "428 đánh giá",
      "location": "Huế - Cách bạn 1.2km",
      "price": "US\$132",
      "image":
          "https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=800&q=80"
    },
    {
      "name": "Vedana Lagoon Resort & Spa",
      "rate": "9.1",
      "reviews": "312 đánh giá",
      "location": "Huế - Cách bạn 14km",
      "price": "US\$98",
      "image":
          "https://images.unsplash.com/photo-1568605114967-8130f3a36994?auto=format&fit=crop&w=800&q=80"
    },
    {
      "name": "La Residence Hue Hotel & Spa",
      "rate": "9.4",
      "reviews": "567 đánh giá",
      "location": "Huế - Cách bạn 2.1km",
      "price": "US\$185",
      "image":
          "https://images.unsplash.com/photo-1568605114967-8130f3a36994?auto=format&fit=crop&w=800&q=80"
    },
    {
      "name": "Moonlight Hotel Hue",
      "rate": "8.9",
      "reviews": "892 đánh giá",
      "location": "Huế - Cách bạn 0.3km",
      "price": "US\$76",
      "image":
          "https://images.unsplash.com/photo-1568605114967-8130f3a36994?auto=format&fit=crop&w=800&q=80"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Danh sách khách sạn"),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_rounded),
            tooltip: "Về trang chủ",
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/mainpage', (route) => false);
            },
          )
        ],
      ),

      // ĐÃ KHẮC PHỤC HOÀN TOÀN LỖI OVERFLOW
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        itemCount: hotels.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, i) {
          final h = hotels[i];
          final bool isHovered = _hoveredIndex == i;

          return MouseRegion(
            onEnter: (_) => setState(() => _hoveredIndex = i),
            onExit: (_) => setState(() => _hoveredIndex = null),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(
                  color: isHovered ? Colors.blue.shade400 : Colors.transparent,
                  width: isHovered ? 2.5 : 0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isHovered ? 0.28 : 0.12),
                    blurRadius: isHovered ? 22 : 10,
                    offset: Offset(0, isHovered ? 12 : 5),
                  ),
                  if (isHovered)
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.25),
                      blurRadius: 30,
                      spreadRadius: 4,
                    ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Đã chọn: ${h["name"]}")),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        // Ảnh khách sạn
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          child: Image.network(
                            h["image"]!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 120,
                              height: 120,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.hotel, size: 40, color: Colors.grey),
                            ),
                          ),
                        ),

                        // Thông tin
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  h["name"]!,
                                  style: TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: isHovered ? FontWeight.bold : FontWeight.w600,
                                    color: isHovered ? Colors.blue.shade900 : Colors.black87,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade700,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        h["rate"]!,
                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      h["reviews"]!,
                                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  h["location"]!,
                                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  h["price"]!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: isHovered ? Colors.deepPurple : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Icon yêu thích
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: AnimatedScale(
                            scale: isHovered ? 1.25 : 1.0,
                            duration: const Duration(milliseconds: 250),
                            child: Icon(
                              isHovered ? Icons.favorite : Icons.favorite_border,
                              color: isHovered ? Colors.red.shade500 : Colors.grey.shade500,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}