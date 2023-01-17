import 'package:flutter/material.dart';
import '../data.dart';
import '../pages/music_page.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:player/utils.dart';

class MusicList extends StatefulWidget {
  const MusicList({
    super.key,
  });

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  final player = AssetsAudioPlayer();
  bool isPlaying = true;
  Duration duration = Duration.zero;
  @override
  void initState() {
    openPlayer();

    player.onReadyToPlay.listen((newDuration) {
      if (mounted) {
        setState(() {
          duration = newDuration?.duration ?? Duration.zero;
        });
      }
    });

    player.isPlaying.listen((event) {
      if (mounted) {
        setState(() {
          isPlaying = event;
        });
      }
    });

    super.initState();
  }

  // define a playlist for player
  void openPlayer() async {
    await player.open(Playlist(audios: songs),
        autoStart: false, showNotification: true, loopMode: LoopMode.playlist);
  }

  @override
  Widget build(BuildContext context) {
    Data data = Data();
    IconData plyBtn = Icons.keyboard_double_arrow_right;

    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Column(
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
                          songs[index].metas.title!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              songs[index].metas.artist!,
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
                              songs[index].metas.id!,
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
                        onPressed: () async {
                          await player.playlistPlayAtIndex(index);
                          setState(() {
                            player.getCurrentAudioImage;
                            player.getCurrentAudioTitle;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MusicPage(
                                index: index,
                                player: player,
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
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
