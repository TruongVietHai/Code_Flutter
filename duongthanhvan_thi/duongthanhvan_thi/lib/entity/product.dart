import 'package:flutter/material.dart';

class Product {
  late String name;
  late String unit;
  late double price;
  late String avtImage;
  late Color avtColor;
  Product(this.name, this.unit, this.price,
      {this.avtColor = Colors.amber, this.avtImage = ""});
}

String url1 =
    "https://benhvienk.vn/data/media/1601/images/16100958642348_tao-do-my-red-delicious-size-36-44.jpg";
String url2 =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIYnWOIA9IPkBW3WT9-8asgVodYSZ4rMvA2w&s";
String url3 =
    "https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2021/10/14/chuoi1-16341869574602070184903.jpg";
String url4=
    "https://suckhoedoisong.qltns.mediacdn.vn/Images/thuhuong/2021/07/04/bo-sung-chat-chong-o-xy-hoa-tu-dua-hau1625376265.jpg";
String url5=
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRufD2pkXraBFJ6vJXHIFWBdMaOc_6JbxX8Bw&s";
String url6=
    "https://www.conngongvang.com/wp-content/uploads/2019/01/nho_den_ninh_thuan-431x431.jpg";


//mock data
var listProduct = [
  Product("Apple", "Kg", 30, avtColor: Colors.red, avtImage: url1),
  Product("Kiwi", "Kg", 40, avtColor: Colors.green, avtImage: url2),
  Product("Banana", "Kg", 30, avtColor: Colors.yellow, avtImage: url3),
  Product("Watermelon", "Kg", 30, avtColor: Colors.red, avtImage: url4),
  Product("Strawberry", "Kg", 40, avtColor: Colors.green, avtImage: url5),
  Product("Grape", "Kg", 30, avtColor: Colors.red, avtImage: url6),
  Product("Kiwi", "Kg", 40, avtColor: Colors.green, avtImage: url2),
  Product("Banana", "Kg", 30, avtColor: Colors.yellow, avtImage: url3),
  Product("Watermelon", "Kg", 30, avtColor: Colors.red, avtImage: url4),
  Product("Strawberry", "Kg", 40, avtColor: Colors.green, avtImage: url5),
  
  
  
];
