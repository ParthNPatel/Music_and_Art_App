import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoLectureViewModel extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();

  Duration totalDuration = Duration.zero;

  Duration currentPosition = Duration.zero;

  bool isPlaying = false;

  bool isFavourite = false;
  setFavourite() {
    isFavourite = !isFavourite;
    update();
  }

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

  var videoUrl;
  setVideoUrl(String value) {
    videoUrl = value;
    setVideo();
    update();
  }

  var videoThumb;
  setVideoThumb(String value) {
    videoThumb = value;
    update();
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    String url = audioUrl;
    await audioPlayer.setSourceUrl(url);
    audioPlayer.play(UrlSource(url));
    isPlaying = true;
    update();
  }

  VideoPlayerController? videoController;

  double sliderValue = 0.0;
  var position = Duration.zero;
  var totalVideoDuration = Duration.zero;
  Future setVideo() async {
    videoController = VideoPlayerController.networkUrl(Uri.parse('$videoUrl'))
      ..initialize().then((_) {
        totalVideoDuration = videoController!.value.duration;
        videoController!.play();
      });
    onVideoPositionChange();
    update();
  }

  void onVideoPositionChange() {
    videoController!.addListener(updateSeeker);
  }

  getVideoPosition() {
    var duration = Duration(
        milliseconds: videoController!.value.position.inMilliseconds.round());
    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  String printTotalDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    // return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<void> updateSeeker() async {
    final newPosition = await videoController!.value.position;
    position = newPosition;
    sliderValue = newPosition.inSeconds.toDouble();
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

  bool isVideo = false;
  updateVideo(bool val) {
    isVideo = val;
    print('IS==${isVideo}');
    update();
  }

  initializedVideoPlayer(BuildContext context) {}
}
