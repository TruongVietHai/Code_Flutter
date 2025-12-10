import 'package:flutter/material.dart';
import 'package:vanduong_thi/entity/shoppingcart.dart'; // Import lớp ShoppingCart

class MyShoppingCart extends StatefulWidget {
  const MyShoppingCart({super.key});

  @override
  State<MyShoppingCart> createState() => _MyShoppingCartState();
}

class _MyShoppingCartState extends State<MyShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Column(
        children: [
          // Kiểm tra giỏ hàng trống hay không
          Expanded(
            child: spc.items.isEmpty
                ? myEmptyShoppingCart()
                : ListView(children: spc.items.map((e) => item(e)).toList()),
          ),
          myBottom(),
        ],
      ),
    );
  }

  // Cập nhật hàm item để hiển thị thông tin của sản phẩm trong giỏ hàng
  Widget item(ItemInCart itc) {
    return Card(
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: itc.avtColor,
            image: itc.avtImg.isNotEmpty
                ? DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(itc.avtImg))
                : null,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${itc.name}"),
                Text("Unit: ${itc.unit}"),
                Text("Price: ${itc.price}"),
              ],
            ),
            Row(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            spc.addItemInCart(itc, quantity: -1);
                          });
                        },
                        icon: const Icon(Icons.remove)),
                    Text("${itc.quantity}"),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            spc.addItemInCart(itc, quantity: 1);
                          });
                        },
                        icon: const Icon(Icons.add)),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      spc.remove(itc);
                    });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget myEmptyShoppingCart() {
    return const Center(
      child: Text(
        "Your shopping cart is empty",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  SizedBox myBottom() {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Sub total"),
                Text(
                    "\$${spc.getTotal2().toStringAsFixed(2)}"), // Sử dụng getTotal từ shoppingCart
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.orange),
              child: const Center(
                child: Text(
                  "Proceed to Pay",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.orange,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 25,
        ),
      ),
      title: const Text(
        "My Shopping Cart",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            spc.items.isEmpty ? const SizedBox.shrink() : redPoint(),
          ],
        ),
      ],
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
}
