import 'package:flutter/material.dart';

// -------------------- MODEL LỚP HỌC --------------------
class Course {
  final String title;
  final String code;
  final int students;
  final String imageUrl;

  Course({
    required this.title,
    required this.code,
    required this.students,
    required this.imageUrl,
  });
}

// -------------------- DANH SÁCH LỚP --------------------
final List<Course> courses = [
  Course(
    title: 'XML và ứng dụng - Nhóm 1',
    code: '2025-2026.1.TIN4583.001',
    students: 58,
    imageUrl:
        'https://images.unsplash.com/photo-1517842645767-c639042777db?auto=format&fit=crop&w=900&q=80',
  ),
  Course(
    title: 'Lập trình ứng dụng cho các t...',
    code: '2025-2026.1.TIN4403.006',
    students: 55,
    imageUrl:
        'https://images.unsplash.com/photo-1513258496099-48168024aec0?auto=format&fit=crop&w=900&q=80',
  ),
  Course(
    title: 'Lập trình ứng dụng cho các t...',
    code: '2025-2026.1.TIN4403.005',
    students: 52,
    imageUrl:
        'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=900&q=80',
  ),
  Course(
    title: 'Lập trình ứng dụng cho các t...',
    code: '2025-2026.1.TIN4403.004',
    students: 50,
    imageUrl:
        'https://images.unsplash.com/photo-1512428559087-560fa5ceab42?auto=format&fit=crop&w=900&q=80',
  ),
  Course(
    title: 'Lập trình ứng dụng cho các t...',
    code: '2025-2026.1.TIN4403.003',
    students: 48,
    imageUrl:
        'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=900&q=80',
  ),
];

// -------------------- CARD LỚP (CÓ HIỆU ỨNG HOVER) --------------------
class CourseCard extends StatefulWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        height: 110,
        transform: Matrix4.identity()
          ..scale(isHover ? 1.03 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: isHover
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
          image: DecorationImage(
            image: NetworkImage(widget.course.imageUrl),
            fit: BoxFit.cover,
            colorFilter: isHover
                ? ColorFilter.mode(
                    Colors.black.withOpacity(0.15),
                    BlendMode.darken,
                  )
                : null,
          ),
        ),

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.65),
                Colors.black.withOpacity(0.15),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // tên lớp + icon more
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.course.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight:
                            isHover ? FontWeight.w800 : FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: isHover ? Colors.white : Colors.white70,
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Text(
                widget.course.code,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 12,
                ),
              ),

              const Spacer(),

              Text(
                '${widget.course.students} học viên',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.95),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------- MÀN HÌNH BÀI 1 --------------------
class Bai1ClassroomScreen extends StatelessWidget {
  const Bai1ClassroomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E8EA),

      // ---------------- APPBAR + NÚT QUAY LẠI ----------------
      appBar: AppBar(
        title: const Text("Bài 1 - Classroom"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/mainpage');
              },
              icon: const Icon(Icons.home_outlined, size: 22),
              label: const Text("Trang chủ"),
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue.shade700,
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ],
      ),

      // ---------------- BODY ----------------
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CourseCard(course: courses[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}
