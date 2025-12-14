import 'package:flutter/material.dart';
import '../services/news_api_service.dart';
import 'bai6_news_detail_screen.dart';

class Bai6NewsListScreen extends StatefulWidget {
  const Bai6NewsListScreen({super.key});

  @override
  State<Bai6NewsListScreen> createState() => _Bai6NewsListScreenState();
}

class _Bai6NewsListScreenState extends State<Bai6NewsListScreen> {
  late Future<List<NewsArticle>> news;

  @override
  void initState() {
    super.initState();
    news = NewsApiService.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: const Text("Bài 6 - News List"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, "/mainpage"),
        ),
      ),

      body: Stack(
        children: [
          /// Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade700, Colors.blue.shade200],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          FutureBuilder<List<NewsArticle>>(
            future: news,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Colors.white));
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text("Lỗi tải dữ liệu",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                );
              }

              final data = snapshot.data!;

              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(12, 100, 12, 20),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
                  bool isHover = false;

                  return StatefulBuilder(
                    builder: (context, setState) {
                      return MouseRegion(
                        onEnter: (_) => setState(() => isHover = true),
                        onExit: (_) => setState(() => isHover = false),

                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 240),
                          curve: Curves.easeOutCubic,
                          transform: Matrix4.identity()..scale(isHover ? 1.03 : 1.0),

                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Bai6NewsDetailScreen(article: item),
                                ),
                              );
                            },

                            child: Card(
                              elevation: isHover ? 14 : 6,
                              shadowColor: Colors.black54,
                              margin: const EdgeInsets.only(bottom: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: Column(
                                children: [
                                  /// IMAGE + OVERLAY
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          item.imageUrl.isEmpty
                                              ? "https://via.placeholder.com/300x200?text=No+Image"
                                              : item.imageUrl,
                                          height: 200,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Container(
                                            height: 200,
                                            color: Colors.grey[300],
                                            child: const Icon(Icons.image, size: 40),
                                          ),
                                        ),

                                        /// DARK OVERLAY
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black.withOpacity(0.55),
                                                Colors.black.withOpacity(0.1),
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// TITLE
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        const Icon(Icons.arrow_forward_ios, size: 18),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
