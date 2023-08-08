import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class VideoLectureViewModel extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();

  Duration totalDuration = Duration.zero;

  Duration currentPosition = Duration.zero;

  bool isPlaying = false;

  void onAudioDurationChange() {
    print('DURATION=1 =${totalDuration}');
    audioPlayer.onDurationChanged.listen((Duration duration) {
      totalDuration = duration;
      print('DURATION==${totalDuration}');
      update();
    });
  }

  void onAudioPositionChange() {
    audioPlayer.onPositionChanged.listen((Duration duration) {
      currentPosition = duration;
      update();
    });
  }

  void cutAudioFromStart() {
    if (totalDuration - currentPosition >= Duration(seconds: 10)) {
      audioPlayer.seek(currentPosition + Duration(seconds: 10));
    }
  }

  void cutAudioFromEnd() {
    if (currentPosition >= Duration(seconds: 10)) {
      audioPlayer.seek(currentPosition - Duration(seconds: 10));
    }
  }

  String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    // return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  var audioUrl;
  setUrl(String urlPath) {
    audioUrl = urlPath;
    setAudio();
    update();
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    String url = audioUrl;
    audioPlayer.setSourceUrl(url);
    audioPlayer.play(UrlSource(url));
    isPlaying = true;
    update();
  }

  void audioButtonPress() {
    if (isPlaying) {
      audioPlayer.pause();
    } else {
      audioPlayer.resume();
      // audioPlayer.play(AssetSource('assets/icons/testing.mp3'),
      //     position: currentPosition);
    }
    isPlaying = !isPlaying;
    update();
  }
}
