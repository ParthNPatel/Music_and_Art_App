import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:music_and_art/core/routing/routes.dart';

class SeasonsViewModel extends GetxController {
  List<Map<String, dynamic>> seasonsList = [];
  void navigateToAgeGroupScreen(int index) {
    Get.toNamed(
      Routes.ageGroupScreen,
      arguments: seasonsList[index]['categoriesName'],
    );
  }

  getSeasonsList() async {
    seasonsList.clear();
    setLoadingS(true);
    var getData = await FirebaseFirestore.instance.collection('category').get();
    getData.docs.forEach((element) {
      seasonsList.add({
        'categoriesName': element['categoryName'],
        'categoryImage': element['categoryImage'],
      });
    });
    setLoadingS(false);
    update();
  }

  bool setLoading = false;
  setLoadingS(bool val) {
    setLoading = val;
    update();
  }
}
