import 'package:get/get.dart';

class MemberShipPlanViewModel extends GetxController {
  List<String> membershipName = ['Monatlich', 'Jährlich', 'Lifetime'];
  List<String> membershipPrice = ['90.0 €', '190.0 €', ' 990.0 €'];
  String selectedOption = '';
  changeSelectedValue(String val) {
    selectedOption = val;

    update();
  }
}
