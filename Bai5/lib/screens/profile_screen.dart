import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String email;

  const ProfileScreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    // Thông tin demo – sửa lại theo ý bạn
    const String fullName = 'Trương Viết Hải';
    const String birthDate = '01/01/2004';
    const String address = 'Thành phố Huế, Thừa Thiên Huế, Việt Nam';
    const String phoneNumber = '0123 456 789';
    const String gptNumber = 'GPT-0001';
    const String height = '1m72';
    const String weight = '65 kg';
    const String nationality = 'Việt Nam';
    const String maritalStatus = 'Độc thân';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Thông tin tài khoản'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFFFF1F8),
        actions: [
          IconButton(
            onPressed: () {
              // Đăng xuất: quay lại màn login
              Navigator.pop(context);
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Đăng xuất',
          ),
        ],
      ),
      body: SafeArea(
        // 👇 QUAN TRỌNG: bọc bằng SingleChildScrollView
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Card(
                margin: const EdgeInsets.all(24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar + tên
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.blue.shade100,
                              child: const Icon(
                                Icons.person,
                                size: 48,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              fullName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              email,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 16),

                      const _ProfileRow(
                        icon: Icons.badge_outlined,
                        label: 'Họ và tên',
                        value: fullName,
                      ),
                      const SizedBox(height: 12),

                      const _ProfileRow(
                        icon: Icons.cake_outlined,
                        label: 'Ngày sinh',
                        value: birthDate,
                      ),
                      const SizedBox(height: 12),

                      const _ProfileRow(
                        icon: Icons.home_outlined,
                        label: 'Địa chỉ',
                        value: address,
                      ),
                      const SizedBox(height: 12),

                      const _ProfileRow(
                        icon: Icons.phone_android_outlined,
                        label: 'Số điện thoại',
                        value: phoneNumber,
                      ),
                      const SizedBox(height: 12),

                      const _ProfileRow(
                        icon: Icons.confirmation_number_outlined,
                        label: 'Số GPT',
                        value: gptNumber,
                      ),
                      const SizedBox(height: 12),

                      const _ProfileRow(
                        icon: Icons.height_outlined,
                        label: 'Chiều cao',
                        value: height,
                      ),
                      const SizedBox(height: 12),

                      const _ProfileRow(
                        icon: Icons.monitor_weight_outlined,
                        label: 'Cân nặng',
                        value: weight,
                      ),
                      const SizedBox(height: 12),

                      const _ProfileRow(
                        icon: Icons.flag_outlined,
                        label: 'Quốc tịch',
                        value: nationality,
                      ),
                      const SizedBox(height: 12),

                      const _ProfileRow(
                        icon: Icons.favorite_outline,
                        label: 'Trạng thái hôn nhân',
                        value: maritalStatus,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22, color: Colors.blueGrey),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
