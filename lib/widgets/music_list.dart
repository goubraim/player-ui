import 'package:flutter/material.dart';
import '../data.dart';
import '../pages/music_page.dart';

class MusicList extends StatefulWidget {
  const MusicList({
    super.key,
  });

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  @override
  Widget build(BuildContext context) {
    Data data = Data();
    IconData plyBtn = Icons.keyboard_double_arrow_right;

    return ListView.builder(
      itemCount: data.list.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            const SizedBox(height: 15),
            //for (int i = 1; i < 4; i++)
            Container(
              margin: EdgeInsets.only(top: 15, right: 12, left: 5),
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
              decoration: BoxDecoration(
                color: Color(0xFF30314D),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    (index + 1).toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.list[index]["title"]!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            data.list[index]["singer"]!,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "-",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            data.list[index]["duration"]!,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: IconButton(
                      icon: Icon(
                        plyBtn,
                        color: Colors.lightBlue,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MusicPage(
                              index: index,
                            ),
                          ),
                        );
                        /*
                        if (!isPlaying) {
                          player.open(
                            Audio(data.list[index]["url"]!),
                            showNotification: true,
                          );
                          setState(() {
                            plyBtn = Icons.pause;
                            isPlaying = true;
                          });
                        } else {
                          player.pause();
                          setState(() {
                            plyBtn = Icons.play_arrow;
                            isPlaying = false;
                          });
                        }
                        */
                      },
                    ),
                  ),
                  /*
                  const SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    radius: 20,
                    child: IconButton(
                      icon: const Icon(Icons.stop),
                      onPressed: () {
                        player.stop();
                      },
                    ),
                  ),
                   */
                  /*
                    IconButton(
                      icon: Icon(playBtn),
                      onPressed: () {
                        if (!isPlaying) {
                          setState(() {
                            playBtn = Icons.pause;
                            isPlaying = true;
                          });
                        } else {
                          setState(() {
                            playBtn = Icons.play_arrow;
                            isPlaying = false;
                          });
                        }
                      },
                    ),
                      */
                  /*
                    IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 25,
                        color: Color(0xFF31314F),
                      ),
                      onPressed: () {
                        if (isPlaying){
                          await audioPlayer.pause();
                        } else {
                          await audioPlayer.play("");
                        }
                      },
                    ),
                    */
                  /*
                    Icon(
                      Icons.play_arrow,
                      size: 25,
                      color: Color(0xFF31314F),
                    ),
                    */
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
