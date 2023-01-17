import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

const kPrimaryColor = Color(0xFFebbe8b);

// playlist songs
List<Audio> songs = [
  Audio('assets/audio/alfatiha01.mp3',
      metas: Metas(
          title: 'sourate al fatiha',
          artist: 'saad al ghamdi',
          id: '00:10',
          album: '',
          image: const MetasImage.asset('assets/images/ghamdi.png'))),
  Audio('/assets/audio/alfatiha02.mp3',
      metas: Metas(
          title: 'sourate al fatiha',
          artist: 'abderrahmane soudais',
          id: '00:20',
          album: '',
          image: const MetasImage.asset('assets/images/al-sudais.png'))),
  Audio('/assets/audio/alfatiha03.mp3',
      metas: Metas(
          title: 'sourate al fatiha',
          artist: 'Ahmed al ajmi',
          id: '00:30',
          album: '',
          image: const MetasImage.asset('assets/images/ahmed.jpg'))),
];

String durationFormat(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return '$twoDigitMinutes:$twoDigitSeconds';
  // for example => 03:09
}

// get song cover image colors
Future<PaletteGenerator> getImageColors(AssetsAudioPlayer player) async {
  var paletteGenerator = await PaletteGenerator.fromImageProvider(
    AssetImage(player.getCurrentAudioImage?.path ?? ''),
  );
  return paletteGenerator;
}
