import 'package:flutter/material.dart';
import 'package:vanduong_thi/entity/product.dart';
import 'package:vanduong_thi/entity/shoppingcart.dart'; // Import lớp Shoppingcart

class MyProductList extends StatefulWidget {
  const MyProductList({super.key});

  @override
  State<MyProductList> createState() => _MyProductListState();
}

class _MyProductListState extends State<MyProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.home,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: const Text(
          "PRODUCT LIST",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/shoppingcart");
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
              spc.items.isEmpty ? const SizedBox.shrink() : redPoint()
            ],
          ),
          // IconButton(
          //   onPressed: () => null,
          //   icon: Icon(
          //     Icons.notifications,
          //     color: Colors.purple,
          //   ),
          // ),
          // IconButton(
          //   onPressed: () => null,
          //   icon: Icon(
          //     Icons.search,
          //     color: Colors.orange,
          //   ),
          // )
        ],
      ),
      body: ListView(
        children: List.generate(listProduct.length,
            (index) => ProductItem(listProduct[index], context)),
      ),
    );
  }

  Positioned redPoint() {
    return Positioned(
      right: 5,
      top: 5,
      child: Container(
        height: 10,
        width: 10,
        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      ),
    );
  }

  Widget ProductItem(Product product, BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: product.avtColor,
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(product.avtImage))),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            itemText("Name", product.name),
            itemText("Unit", product.unit),
            itemText("Price", "${product.price}\$"),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            setState(() {
              spc.add(product);
            });
            // Thêm sản phẩm vào giỏ hàng
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.name} added to cart!'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: const Text("Add to cart"),
        ),
      ),
    );
  }

  Text itemText(String label, String value) {
    return Text.rich(TextSpan(text: "$label: ", children: [
      TextSpan(
          text: value,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
    ]));
  }
}
