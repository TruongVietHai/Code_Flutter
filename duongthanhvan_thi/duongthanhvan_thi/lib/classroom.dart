import 'package:flutter/material.dart';
import 'package:vanduong_thi/entity/classroom.dart';
class MyClassroom extends StatelessWidget{
   const MyClassroom({super.key});

 
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView(
        children: [
          item(listClasroom[0]),
          item(listClasroom[1]),
          item(listClasroom[2]),
          item(listClasroom[3]),
          item(listClasroom[4]),
          item(listClasroom[5]),

        ],
      ),
    );
  }
  
  }
  Widget item(Classroom room ){
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          
          fit: BoxFit.cover,
          image: NetworkImage(room.bgUrl)
        ),
            borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("[${room.semeter}]${room.subject}", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold) ),
                Text(room.id, style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 50,),
                Text("${room.totalStudent} học viên", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Icon(Icons.more_horiz)
        ],
      ),
    );
  }
  
