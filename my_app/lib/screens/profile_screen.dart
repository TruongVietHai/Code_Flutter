import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String email;

  const ProfileScreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    // Thông tin mẫu — có thể thay bằng dữ liệu thật khi bạn dùng Provider hoặc Database
    const String fullName = 'Trương Viết Hải';
    const String birthDate = '27/08/2004';
    const String address = 'Thành phố Huế, Việt Nam';
    const String phoneNumber = '0787510351';
    const String studentCode = '22T1020593';
    const String gpa = '3.0 / 4.0';
    const String school = 'Đại học Khoa học – Đại học Huế';
    const String ethnicity = 'Kinh';
    const String politicalStatus = 'Đảng viên ưu tú';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Thông tin tài khoản'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/mainpage',
                (route) => false,
              );

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Đã đăng xuất thành công!"),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Card(
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Avatar + Email
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.blue.shade100,
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              fullName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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

                      const SizedBox(height: 25),
                      const Divider(),
                      const SizedBox(height: 15),

                      const _ProfileInfo(
                        icon: Icons.badge_outlined,
                        label: "Họ và tên",
                        value: fullName,
                      ),
                      const SizedBox(height: 14),

                      const _ProfileInfo(
                        icon: Icons.calendar_month_outlined,
                        label: "Ngày sinh",
                        value: birthDate,
                      ),
                      const SizedBox(height: 14),

                      const _ProfileInfo(
                        icon: Icons.home_outlined,
                        label: "Địa chỉ",
                        value: address,
                      ),
                      const SizedBox(height: 14),

                      const _ProfileInfo(
                        icon: Icons.phone_android_outlined,
                        label: "Số điện thoại",
                        value: phoneNumber,
                      ),
                      const SizedBox(height: 14),

                      const _ProfileInfo(
                        icon: Icons.credit_card_outlined,
                        label: "Mã Sinh Viên",
                        value: studentCode,
                      ),
                      const SizedBox(height: 14),

                      /// ⭐ THÊM 4 DÒNG MỚI
                      const _ProfileInfo(
                        icon: Icons.school_outlined,
                        label: "GPA hiện tại",
                        value: gpa,
                      ),
                      const SizedBox(height: 14),

                      const _ProfileInfo(
                        icon: Icons.account_balance_outlined,
                        label: "Trường",
                        value: school,
                      ),
                      const SizedBox(height: 14),

                      const _ProfileInfo(
                        icon: Icons.group_outlined,
                        label: "Dân tộc",
                        value: ethnicity,
                      ),
                      const SizedBox(height: 14),

                      const _ProfileInfo(
                        icon: Icons.star_outlined,
                        label: "Đối tượng chính trị",
                        value: politicalStatus,
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

/// WIDGET HIỂN THỊ TỪNG DÒNG THÔNG TIN
class _ProfileInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProfileInfo({
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
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
