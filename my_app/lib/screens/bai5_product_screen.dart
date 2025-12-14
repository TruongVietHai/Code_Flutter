import 'package:flutter/material.dart';
import 'api_service.dart';
import 'product_model.dart';
import 'product_detail_screen.dart';

class Bai5ProductScreen extends StatefulWidget {
  const Bai5ProductScreen({super.key});

  @override
  State<Bai5ProductScreen> createState() => _Bai5ProductScreenState();
}

class _Bai5ProductScreenState extends State<Bai5ProductScreen> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = ApiService.fetchProducts();  
  }

  // Nút quay về màn chính
  void goHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, "/mainpage", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bài 5 - Product"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.home, size: 28),
            tooltip: "Về trang chính",
            onPressed: () => goHome(context),
          ),
        ],
      ),

      body: FutureBuilder(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Lỗi tải dữ liệu: ${snapshot.error}"),
            );
          }

          List<Product> data = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.72,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final product = data[index];
              bool isHover = false;

              return StatefulBuilder(
                builder: (context, setState) {
                  return MouseRegion(
                    onEnter: (_) => setState(() => isHover = true),
                    onExit: (_) => setState(() => isHover = false),

                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,

                      // Hiệu ứng scale + bóng đổ khi hover
                      transform: Matrix4.identity()
                        ..scale(isHover ? 1.05 : 1.0),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: isHover
                            ? [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.35),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 8),
                                )
                              ]
                            : [],
                      ),

                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailScreen(product: product),
                            ),
                          );
                        },

                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: isHover ? 10 : 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Ảnh sản phẩm
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                  child: Image.network(
                                    product.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              // Tên sản phẩm
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  product.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: isHover ? 17 : 15,
                                    fontWeight: FontWeight.bold,
                                    color: isHover
                                        ? Colors.blue.shade700
                                        : Colors.black87,
                                  ),
                                ),
                              ),

                              // Giá
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, bottom: 12),
                                child: Text(
                                  "\$${product.price}",
                                  style: TextStyle(
                                    fontSize: isHover ? 18 : 16,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
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
    );
  }
}
