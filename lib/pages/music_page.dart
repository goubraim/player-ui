import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import '../data.dart';
import '../widgets/format_time.dart';

class MusicPage extends StatefulWidget {
  final int index;
  const MusicPage({super.key, required this.index});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  Data data = Data();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  IconData plyBtn = Icons.play_arrow;
  AssetsAudioPlayer player = AssetsAudioPlayer();
  ///////
  final player2 = AssetsAudioPlayer();
  double _currentPosition = 0;
  double _maxDuration = 0;
  Icon _playPauseIcon = Icon(Icons.play_arrow);
  /////

  @override
  Widget build(BuildContext context) {
    int index;
    @override
    void dispose() {
      player.dispose();
      player2.dispose();
      super.dispose();
    }

    @override
    void initState() {
      super.initState();
      player2.open(
        Audio(data.list[widget.index]["url"]!),
        showNotification: true,
      );
      player2.play();
      player2.currentPosition.listen((duration) {
        setState(() {
          _currentPosition = duration.inSeconds.toDouble();
          _playPauseIcon = player2.playerState.value == PlayerState.play
              ? Icon(Icons.pause)
              : Icon(Icons.play_arrow);
        });
      });
      player2.current.listen((Playing) {
        setState(() {
          _maxDuration = Playing!.audio.duration.inSeconds.toDouble();
        });
      });
      /*
      /// listen play pause stop
      player.onReadyToPlay.listen((state) {
        setState(() {
          isPlaying = state == PlayerState.play;
        });
      });
      */
      /*
      //// listen audio duration
      player.onDurationChanged.listen((newDuration) {
        setState(() {
          duration = newDuration;
        });
      });
      // listen audio position
      player.onPositionChanged.listen((newPosition) {
        setState(() {
          position = newPosition;
        });
      });

      */
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/backroundPlay.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.5),
                Color(0xFF31314F).withOpacity(1),
                Color(0xFF31314F).withOpacity(1),
              ],
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 45, horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // function
                        },
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    child: Image.asset(data.list[widget.index]["coverUrl"]!),
                    height: 300,
                    width: 200,
                  ),
                ),
                Spacer(),
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 23, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.list[widget.index]["title"]!,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  data.list[widget.index]["singer"]!,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.favorite,
                              color: Colors.pink,
                              size: 35,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          /*
                          Slider(
                            min: 0,
                            max: duration.inSeconds.toDouble(),
                            value: position.inSeconds.toDouble(),
                            onChanged: (value) async {
                              final position = Duration(seconds: value.toInt());
                              await player.seek(position);
                              // play audio if was pause slide
                              //await player.resume();
                            },
                            activeColor: Colors.white,
                            inactiveColor: Colors.white54,
                          ),
                          */
                          Slider(
                            value: _currentPosition,
                            onChanged: (value) {
                              setState(() {
                                _currentPosition = value;
                              });
                              player2.seek(Duration(
                                  milliseconds:
                                      (_currentPosition * 1000).toInt()));
                            },
                            min: 0,
                            max: _maxDuration,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  //_currentPosition.toString(),
                                  formatTime(position),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  //(_maxDuration - _currentPosition).toString(),
                                  //formatTime(duration - position),
                                  data.list[widget.index]["duration"]!,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.list,
                            color: Colors.white,
                            size: 32,
                          ),
                          IconButton(
                            icon: Icon(Icons.skip_previous),
                            color: Colors.white,
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          CircleAvatar(
                            radius: 25,
                            child: IconButton(
                              iconSize: 25,
                              onPressed: () {
                                if (!isPlaying) {
                                  player2.open(
                                    Audio(data.list[widget.index]["url"]!),
                                  );
                                  setState(() {
                                    plyBtn = Icons.pause;
                                    isPlaying = true;
                                  });
                                } else {
                                  player2.pause();
                                  setState(() {
                                    plyBtn = Icons.play_arrow;
                                    isPlaying = false;
                                  });
                                }
                              },
                              icon: Icon(
                                plyBtn,
                                color: Colors.white,
                                //size: 50,
                              ),
                            ),
                          ),
                          /*
                          IconButton(
                            onPressed: () {
                              if (player2.playerState.value ==
                                  PlayerState.pause) {
                                player2.play();
                              } else {
                                player2.pause();
                              }
                            },
                            icon: _playPauseIcon,
                          ),
                          */
                          IconButton(
                            icon: Icon(Icons.skip_next),
                            color: Colors.white,
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.stop_rounded,
                              color: Colors.red,
                            ),
                            iconSize: 32,
                            onPressed: () async {
                              await player2.stop();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





/*
CircleAvatar(
                              radius: 25,
                              child: IconButton(
                                onPressed: () {
                                  if (!isPlaying) {
                                    player.play(
                                      AssetSource(
                                          data.list[widget.index]["url"]!),
                                    );
                                    setState(() {
                                      plyBtn = Icons.pause;
                                      isPlaying = true;
                                    });
                                  } else {
                                    setState(() {
                                      plyBtn = Icons.play_arrow;
                                      isPlaying = false;
                                    });
                                    player.pause;
                                  }
                                },
                                icon: Icon(
                                  Icons.play_arrow,
                                ),
                              )),
*/







    /////
    /*
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/backroundPlay.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          /*
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.5),
                Color(0xFF31314F).withOpacity(1),
                Color(0xFF31314F).withOpacity(1),
              ],
            ),
          ),
          */
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 45, horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // function
                        },
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    child: Image.asset(data.list[0]["coverUrl"]!),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 1.5,
                  ),
                ),
                Spacer(),
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 23, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.list[0]["singer"]!,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'SInger Name',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.favorite,
                              color: Colors.redAccent,
                              size: 35,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Slider(
                            min: 0,
                            max: 100,
                            value: 40,
                            onChanged: (value) {},
                            activeColor: Colors.white,
                            inactiveColor: Colors.white54,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '02:65',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '04:25',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.list,
                            color: Colors.white,
                            size: 32,
                          ),
                          Icon(
                            CupertinoIcons.backward_end_fill,
                            color: Colors.white,
                            size: 30,
                          ),
                          Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.play_arrow,
                              color: Color(0xFF31314F),
                              size: 45,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.forward_end_fill,
                            color: Colors.white,
                            size: 30,
                          ),
                          Icon(
                            Icons.download,
                            color: Colors.white,
                            size: 32,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    */
