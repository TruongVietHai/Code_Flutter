import 'package:flutter/material.dart';
import 'package:vanduong_thi/entity/pageviewinfo.dart';

class MyMeeting extends StatefulWidget {
  const MyMeeting({super.key});

  @override
  State<MyMeeting> createState() => _MyMeetingState();
}

class _MyMeetingState extends State<MyMeeting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(),
      drawer: myDrawer(context),
      bottomNavigationBar: myBottom(),
      body: myBody(),
    );
  }

  Widget myBody() {
    return SingleChildScrollView(  // Thêm SingleChildScrollView để cuộn được
      child: Column(
        children: [
          myRowButton(),
          myPageView(),
          myIndicator(),
        ],
      ),
    );
  }

  int currentPage = 0;

  Widget myIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          listPageViewMeeting.length,
          (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: currentPage == index ? Colors.red : Colors.grey,
                  shape: BoxShape.circle,
                ),
              )),
    );
  }

  Widget myPageView() {
    return SizedBox(
      height: 300,  // Giới hạn chiều cao của PageView để nó không chiếm quá nhiều không gian
      child: PageView(
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        children:
            listPageViewMeeting.map((page) => myPageViewItem(page)).toList(),
      ),
    );
  }

  Widget myPageViewItem(PageViewInfo page) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(page.avtUrl),
              fit: BoxFit.cover
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Cuộc họp luôn an toàn",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(page.content),
      ],
    );
  }

  Widget myRowButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.blueGrey),
          ),
          child: const Text(
            "Cuộc họp mới",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.blueGrey),
          ),
          child: const Text(
            "Tham gia cuộc họp",
            style: TextStyle(color: Color.fromARGB(255, 90, 116, 138)),
          ),
        ),
      ],
    );
  }

  Widget myDrawer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 2 / 3,
      decoration: const BoxDecoration(color: Colors.white),
    );
  }

  AppBar myAppbar() {
    return AppBar(
      title: const Center(child: Text("Họp mặt")),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blueGrey),
          ),
        )
      ],
    );
  }

  Widget myBottom() {
    return BottomNavigationBar(
      currentIndex: 2,
      selectedItemColor: Colors.red,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.email), label: "Email"),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
        BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "Meeting"),
      ],
    );
  }
}
