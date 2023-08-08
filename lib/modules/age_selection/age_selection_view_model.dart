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
    Get.toNamed(Routes.ageContentScreen, arguments: index);
  }

  void navigateToVideoLectureScreen(int index) {
    if (ageContentList[index]['addAudio'] == null ||
        ageContentList[index]['addAudio'] == '') {
      videoLectureViewModel.setUrl(
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
    } else {
      videoLectureViewModel.setUrl(ageContentList[index]['addAudio']);
    }
    Get.toNamed(Routes.videoLectureScreen, arguments: index);
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
        .where('categoriesName', isEqualTo: name)
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
      });
    });
    setLoadingS(false);
    print('ageContentList::::${ageContentList.length}');
    update();
  }
}
