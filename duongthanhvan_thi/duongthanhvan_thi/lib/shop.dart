import 'package:flutter/material.dart';
import 'package:vanduong_thi/entity/product2.dart';
import 'package:vanduong_thi/utils/api_service.dart';

class MyShop extends StatefulWidget {
  const MyShop({super.key});

  @override
  State<MyShop> createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  late Future<List<Product2>> lsProduct2;

  @override
  void initState() {
    super.initState();
    lsProduct2 = ApiService.getAllProduct(); // Gọi API để lấy dữ liệu sản phẩm
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cửa hàng của tôi", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<Product2>>(
        future: lsProduct2,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Đã xảy ra lỗi: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Không có sản phẩm nào."));
          } else {
            var data = snapshot.data!;
            return MyListView(data);
          }
        },
      ),
    );
  }

  Widget MyListView(List<Product2> ls) {
    return ListView(
      children: ls.map((product) => MyItem(product)).toList(),
    );
  }

  Widget MyItem(Product2 p) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(p.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(p.description, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 10),
              Text("Giá: \$${p.price.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("Danh mục: ${p.category}", style: const TextStyle(fontStyle: FontStyle.italic)),
              const SizedBox(height: 10),
              Text("ID: ${p.id}", style: const TextStyle(fontStyle: FontStyle.italic)),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  Text(" ${p.rating.rate} (${p.rating.count} đánh giá)", style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Đóng", style: TextStyle(color: Colors.purple)),
            ),
          ],
        ),
      ),
      child: Card(
        margin: const EdgeInsets.all(8),
        elevation: 4,
        child: ListTile(
          leading: Image.network(p.image, width: 50, height: 50, fit: BoxFit.cover),
          title: Text(p.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              Text("${p.rating.rate} (${p.rating.count} đánh giá)", style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }
}
