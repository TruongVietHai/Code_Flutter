import 'package:flutter/material.dart';

// Model dữ liệu 1 khách sạn
class Hotel {
  final String name;
  final double rating;
  final int reviewCount;
  final String area;
  final double distanceKm;
  final String roomInfo;
  final String priceText;
  final String imageUrl;
  final bool breakfastIncluded;

  Hotel({
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.area,
    required this.distanceKm,
    required this.roomInfo,
    required this.priceText,
    required this.imageUrl,
    this.breakfastIncluded = false,
  });
}

// Danh sách khách sạn mẫu (bạn có thể chỉnh sửa thêm)
final List<Hotel> hotels = [
  Hotel(
    name: 'aNhill Boutique',
    rating: 9.5,
    reviewCount: 95,
    area: 'Huế',
    distanceKm: 0.6,
    roomInfo: '1 suite riêng tư · 1 giường',
    priceText: 'US\$109',
    imageUrl:
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=900&q=80',
    breakfastIncluded: true,
  ),
  Hotel(
    name: 'An Nam Hue Boutique',
    rating: 9.2,
    reviewCount: 34,
    area: 'Cư Chánh',
    distanceKm: 0.9,
    roomInfo: '1 phòng khách sạn · 1 giường',
    priceText: 'US\$20',
    imageUrl:
        'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?auto=format&fit=crop&w=900&q=80',
    breakfastIncluded: true,
  ),
  Hotel(
    name: 'Huế Jade Hill Villa',
    rating: 8.0,
    reviewCount: 1,
    area: 'Cư Chánh',
    distanceKm: 1.3,
    roomInfo: '1 biệt thự nguyên căn · 4 giường · 3 phòng ngủ · 3 phòng tắm',
    priceText: 'US\$285',
    imageUrl:
        'https://images.unsplash.com/photo-1505691723518-36a5ac3be353?auto=format&fit=crop&w=900&q=80',
    breakfastIncluded: false,
  ),
   Hotel(
    name: 'Huế Jade Hill Villa',
    rating: 8.0,
    reviewCount: 1,
    area: 'Cư Chánh',
    distanceKm: 1.3,
    roomInfo: '1 biệt thự nguyên căn · 4 giường · 3 phòng ngủ · 3 phòng tắm',
    priceText: 'US\$285',
    imageUrl:
        'https://images.unsplash.com/photo-1505691723518-36a5ac3be353?auto=format&fit=crop&w=900&q=80',
    breakfastIncluded: false,
  ),
];

class HotelListScreen extends StatelessWidget {
  const HotelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _TopBar(),
                const SizedBox(height: 8),
                const _FilterBar(),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    '${hotels.length} chỗ nghỉ',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    itemCount: hotels.length,
                    itemBuilder: (context, index) {
                      final hotel = hotels[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: HotelCard(hotel: hotel),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Thanh trên cùng: nút back + vị trí + ngày (ô vàng giống hình)
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D47A1), // xanh đậm giống app
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // nếu sau này có navigator thì dùng Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.orange.shade400,
                  width: 2,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Xung quanh vị trí hiện tại',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '23 thg 10  -  24 thg 10',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Thanh lọc / sắp xếp / bản đồ
class _FilterBar extends StatelessWidget {
  const _FilterBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _FilterButton(icon: Icons.sort, label: 'Sắp xếp'),
          _FilterButton(icon: Icons.tune, label: 'Lọc'),
          _FilterButton(icon: Icons.map, label: 'Bản đồ'),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FilterButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: const BorderSide(color: Colors.grey),
      ),
      icon: Icon(
        icon,
        size: 16,
        color: Colors.black87,
      ),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black87,
        ),
      ),
    );
  }
}

// Thẻ hiển thị 1 khách sạn trong danh sách
class HotelCard extends StatelessWidget {
  final Hotel hotel;

  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ảnh khách sạn
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: SizedBox(
              width: 110,
              height: 110,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      hotel.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (hotel.breakfastIncluded)
                    Positioned(
                      top: 8,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Bao bữa sáng',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Thông tin bên phải
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên + tim
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          hotel.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Điểm rating
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF003580),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          hotel.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Xuất sắc · ${hotel.reviewCount} đánh giá',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Khu vực + khoảng cách
                  Text(
                    '${hotel.area} · Cách bạn ${hotel.distanceKm}km',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Thông tin phòng
                  Text(
                    hotel.roomInfo,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Giá
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      hotel.priceText,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
