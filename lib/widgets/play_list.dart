import 'package:flutter/material.dart';

import '../data.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    ///// varialbes
    Data data = Data();
    /////

    return ListView.builder(
      itemCount: data.list.length,
      itemBuilder: (context, index) {
        return SingleChildScrollView(
          child: Column(
            children: [
              //for (int i = 1; i < 20; i++)
              Container(
                margin: EdgeInsets.only(top: 20, right: 20, left: 5),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xFF30314D),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'playListPage');
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          data.list[index]["coverUrl"]!,
                          //'assets/images/backround.png',
                          fit: BoxFit.cover,
                          height: 60,
                          width: 60,
                        ),
                      ),
                    ),
                    SizedBox(width: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.list[index]["singer"]!,
                          //'Imagine Dragons',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '60 song',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.more_vert,
                      color: Colors.white.withOpacity(0.6),
                      size: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
        /*
        Card(
          child: Column(
            children: [
              Text(data.list[index]["title"]!),
              Text(data.list[index]["desc"]!),
              Image.asset(data.list[index]["coverUrl"]!),
              Text(
                  "${data.list[index]["duration"].inMinutes}m ${data.list[index]["duration"].inSeconds % 60}s"),
            ],
          ),
        );
        */
      },
    );
  }
}
