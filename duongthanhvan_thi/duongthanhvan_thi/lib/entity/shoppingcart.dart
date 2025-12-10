import 'package:flutter/material.dart';
import 'package:vanduong_thi/entity/product.dart';

class ItemInCart {
  late String name;
  late String unit;
  late double price;
  late String avtImg;
  late Color avtColor;
  late int quantity;

  ItemInCart(this.name, this.unit, this.price, this.avtImg, this.avtColor,
      this.quantity);
}

class Shoppingcart {
  late List<ItemInCart> items;

  Shoppingcart() {
    items = [];
  }
  /*
  // Thêm sản phẩm vào giỏ hàng
  void add(Product product, {int quantity = 1}) {
    // Kiểm tra xem sản phẩm đã có trong giỏ chưa
    var existingItem = item.firstWhere(
      (cartItem) => cartItem.name == product.name,
      orElse: () => ItemInCart("", "", 0, "", Colors.transparent, 0),
    );

    if (existingItem.name.isEmpty) {
      // Nếu sản phẩm chưa có trong giỏ, thêm mới
      item.add(ItemInCart(
        product.name,
        product.unit,
        product.price,
        product.avtImage,
        product.avtColor,
        quantity,
      ));
    } else {
      // Nếu sản phẩm đã có, tăng số lượng
      existingItem.quantity += quantity;
    }
  }
  */
  void add(Product product, {int quantity = 1}) {
    for (var item in items) {
      if (item.name == product.name) {
        item.quantity += quantity;
        return;
      }
    }
    var item = ItemInCart(
      product.name,
      product.unit,
      product.price,
      product.avtImage,
      product.avtColor,
      quantity,
    );
    items.add(item);
  }

  void addItemInCart(ItemInCart itc, {int quantity = 1}) {
    for (var item in items) {
      if (item.name == itc.name) {
        item.quantity += quantity;
        if (item.quantity == 0) {
          item.quantity = 1;
          return;
        }
      }
    }
  }

  void remove(ItemInCart itc) {
    items.removeWhere((item) => item.name == itc.name);
  }

  /*
  // Xóa sản phẩm khỏi giỏ hàng
  void remove(Product product, {int quantity = 1}) {
    var existingItem = item.firstWhere(
      (cartItem) => cartItem.name == product.name,
      orElse: () => ItemInCart("", "", 0, "", Colors.transparent, 0),
    );

    if (existingItem.name.isNotEmpty) {
      existingItem.quantity -= quantity;
      if (existingItem.quantity <= 0) {
        item.remove(existingItem);
      }
    }
  }

  // Xóa hoàn toàn một sản phẩm khỏi giỏ
  void delete(Product product) {
    item.removeWhere((cartItem) => cartItem.name == product.name);
  }
  
  // Tính tổng giá trị giỏ hàng
  double getTotal() {
    double total = 0;
    for (var cartItem in item) {
      total += cartItem.price * cartItem.quantity;
    }
    return total;
  }
  */
  double getTotal() {
    double total = 0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  double getTotal2() {
    return items.fold(0, (s, item) => (s + item.price * item.quantity));
  }
}

// Tạo một đối tượng giỏ hàng toàn cục

var spc = Shoppingcart();
