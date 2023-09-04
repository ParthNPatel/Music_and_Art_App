import 'package:get/get.dart';
import 'package:music_and_art/constants/strings.dart';

class ProfileViewModel extends GetxController {
  int? isSelect = -1;
  updateIsSelected(int val) {
    isSelect = val;
    update();
  }

  List<dynamic> profileOptionList = [
    ProfileOptionString.profilWechseln,
    ProfileOptionString.aboVerwalten,
    ProfileOptionString.profilLschen,
    ProfileOptionString.abmelden
  ];
  List profileList = [
    ProfileScreenString.thema,
    ProfileScreenString.meinProfil,
    ProfileScreenString.sprache,
    ProfileScreenString.musikStore,
    ProfileScreenString.ausloggen
  ];
}
