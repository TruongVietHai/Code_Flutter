import 'package:flutter/material.dart';

class MyPlace extends StatefulWidget {
  const MyPlace({super.key});

  @override
  State<MyPlace> createState() => _MyPlaceThayState();
}

class _MyPlaceThayState extends State<MyPlace> {
  String bannerUrl =
      "https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcQLBEeqaVk0VAbyuoEr5Sw3qJSJkGqLU1Q-IHGwXV2o-Ko-gyA8Yo0q41p3wfERFat2ZqT_YPW3VZU97b9CIHzKTEB-vMCEyr5BzGLl6w";
  bool likeStatus = true;
  int countLike = 41;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [banner(), header(), listButtons(), description()],
      ),
    );
  }

  Widget banner() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(bannerUrl))),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kinh Đô Huế",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Thừa Thiên Huế, Việt Nam",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    if (likeStatus) {
                      countLike -= 1;
                    } else {
                      countLike += 1;
                    }
                    likeStatus = !likeStatus;
                  });
                },
                child: const Icon(
                  Icons.star,
                  color: Colors.red,
                ),
              ),
              Text("$countLike"),
            ],
          )
        ],
      ),
    );
  }

  Widget listButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buttonActivity(Icons.phone, "PHONE", color: Colors.blue),
        buttonActivity(Icons.route, "ROUTE", color: Colors.red),
        buttonActivity(Icons.share, "SHARE", color: Colors.green),
      ],
    );
  }

  Widget buttonActivity(IconData icon, String str,
      {Color color = Colors.blue}) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
        ),
        Text(
          str,
          style: TextStyle(color: color),
        ),
      ],
    );
  }

  Widget description() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        "Kinh thành Huế, cố cung Huế hay Thuận Hóa kinh thành là một tòa thành ở cố đô Huế, nơi đóng đô của triều đại nhà Nguyễn trong suốt 143 năm từ 1802 đến khi thoái vị vào năm 1945. Hiện nay, Kinh thành Huế là một trong số các di tích thuộc cụm Quần thể di tích Cố đô Huế được UNESCO công nhận là Di sản Văn hoá Thế giới.",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
