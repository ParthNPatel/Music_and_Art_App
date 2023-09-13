import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:music_and_art/core/routing/routes.dart';
import 'package:music_and_art/modules/videoLecture/video_lecture_view_model/video_lecture_view_model.dart';

class AgeSelectionViewModel extends GetxController {
  final VideoLectureViewModel videoLectureViewModel = Get.find();
  void navigateToBack() {
    Get.back();
  }

  void navigateToAgeContentScreen(int index) {
    getAgeContentList(
        ageName: ageGroupList[index]['ageName'],
        categoriesId: ageGroupList[index]['categoriesId']);
    Get.toNamed(Routes.ageContentScreen,
        arguments: index == 0
            ? '1-3 jahre'
            : index == 1
                ? '3-7 jahre'
                : index == 2
                    ? '7-11 jahre'
                    : ageGroupList[index]['ageName']);
    getVideoString();
  }

  void navigateToVideoLectureScreen(int index) {
    if (getVideo.isNotEmpty) {
      for (int i = 0; i < getVideo.length; i++) {
        if (getVideo[i].containsValue(ageContentList[index]['ageId']) &&
            getVideo[i]
                .containsValue(ageContentList[index]['ageContentName'])) {
          print('DATA==${getVideo[i]['addDataVideo']}');
          videoLectureViewModel.updateVideo(true);
          videoLectureViewModel.setVideoUrl(getVideo[i]['addDataVideo']);
          videoLectureViewModel.setVideoThumb(getVideo[i]['addDataImage']);
          Get.toNamed(Routes.videoLectureScreen, arguments: index);
          break;
        } else {
          videoLectureViewModel.updateVideo(false);
          if (ageContentList[index]['addAudio'] == null ||
              ageContentList[index]['addAudio'] == '') {
          } else {
            videoLectureViewModel.setUrl(ageContentList[index]['addAudio']);
          }
          Get.toNamed(Routes.videoLectureScreen, arguments: index);
        }
      }
    } else {
      videoLectureViewModel.updateVideo(false);
      if (ageContentList[index]['addAudio'] == null ||
          ageContentList[index]['addAudio'] == '') {
      } else {
        videoLectureViewModel.setUrl(ageContentList[index]['addAudio']);
      }
      Get.toNamed(Routes.videoLectureScreen, arguments: index);
    }
  }

  void navigationToProfileScreen() {
    Get.toNamed(Routes.profileScreen);
  }

  bool setLoading = false;
  setLoadingS(bool val) {
    setLoading = val;
    update();
  }

  List<Map<String, dynamic>> ageGroupList = [];
  getAgeGroupList(String? name) async {
    ageGroupList.clear();
    setLoadingS(true);
    var getData = await FirebaseFirestore.instance
        .collection('ageGroup')
        .where(
          'categoriesName',
          isEqualTo: name,
        )
        .get();

    getData.docs.forEach((element) {
      ageGroupList.add({
        'categoriesId': element['categoriesId'],
        'ageImage': element['ageImage'],
        'categoriesName': element['categoriesName'],
        'ageName': element['ageName'],
      });
    });
    setLoadingS(false);
    update();
  }

  List<Map<String, dynamic>> ageContentList = [];
  getAgeContentList({String? ageName, String? categoriesId}) async {
    ageContentList.clear();
    setLoadingS(true);
    var getData = await FirebaseFirestore.instance
        .collection('ageContent')
        .where('ageName', isEqualTo: ageName)
        .where('categoriesId', isEqualTo: categoriesId)
        .get();

    getData.docs.forEach((element) {
      ageContentList.add({
        'categoriesId': element['categoriesId'],
        'ageImage': element['ageImage'],
        'ageContentName': element['ageContentName'],
        'addAudio': element['addAudio'],
        'ageId': element['ageId'],
      });
    });
    setLoadingS(false);
    print('ageContentList::::${ageContentList.length}');
    update();
  }

  List<Map<String, dynamic>> getVideo = [];
  getVideoString() async {
    getVideo.clear();
    var getData = await FirebaseFirestore.instance.collection('video').get();
    getData.docs.forEach((element) {
      getVideo.add({
        'addDataVideo': element['addDataVideo'],
        'addDataImage': element['addDataImage'],
        'ageId': element['ageId'],
        'addAudio': element['addAudio'],
        'addaDataName': element['addaDataName'],
        'description': element['description'],
        'ageContentName': element['ageContentName'],
      });
    });
    log('getVideo::::${getVideo}');
    log('getVideo::::${getVideo.length}');
    update();
  }
}
