import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget{
  MyHomePage({super.key});
  String urlImage =
    "lib/cover1.jpg";


  @override
  Widget build(BuildContext){
    return Scaffold(
      body: ListView(children: [
          flagVietNam(),
          flashCard(urlImage),
          const SizedBox(
            height: 20,
          ), 
          greedy(Colors.red,Colors.yellow, "Hello, Việt Nam") ,
          const SizedBox(
            height: 20,
          ),
          greedy(
            const Color.fromARGB(255, 62, 16, 230),
            const Color.fromARGB(255, 255, 255, 255),
             "Hello, Univesity of Sciences!") ,
          const SizedBox(
            height: 20,
          ), 
          greedy(
            const Color.fromARGB(255, 235, 231, 8),
            const Color.fromARGB(255, 255, 255, 255),
             "Hello, K45") ,  
            
          flagVietNam(), 
          flagVietNam()]),
      );
  }

  Widget flashCard(String bgUrl) {
    return Container(
      height: 300,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          opacity: 0.3,
          fit: BoxFit.cover,image: NetworkImage(bgUrl)),
        color: Colors.grey),
      child: Center(child: Text(
        "XIN CHÀO TRƯỜNG ĐẠI HỌC KHOA HỌC",
         style: TextStyle(
          shadows: [BoxShadow(color: Colors.black, offset: Offset(1, 1))],
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      )),
    );
  }

  Widget greedy(Color bgcolor, Color fgColor, String str) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(blurRadius: 1, color: Colors.black, offset: Offset(2, 2))],
        borderRadius: BorderRadius.circular(20), color: bgcolor),
      child: Center(
        child: Text(
          str, 
        style: TextStyle(
            color: fgColor,
            fontSize: 20,
            fontWeight: FontWeight.bold)
       )));
  }

  Widget flagVietNam() {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 400,
      decoration: const BoxDecoration(color: Colors.red),
      child: const Center(
        child: Icon(
     Icons.star,
        color: Colors.yellow, 
        size: 200,
      )),
    );
  }
}