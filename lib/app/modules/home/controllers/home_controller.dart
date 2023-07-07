import 'package:get/get.dart';
import 'package:our_wallet/app/data/constant.dart';

class HomeController extends GetxController {
  var isLoading = true;
  var isShow = false;
  var greeting = '';
  var index = 0;
  var list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  var cardMenu = [
    {
      "name": "Top Up",
      "icon": "$pngPath/topup.png",
      "route": "",
    },
    {
      "name": "Pay",
      "icon": "$pngPath/payment.png",
      "route": "",
    },
    {
      "name": "Chart",
      "icon": "$pngPath/barchart.png",
      "route": "",
    },
    {
      "name": "Invite",
      "icon": "$pngPath/invitation.png",
      "route": "",
    },
  ];

  @override
  void onInit() {
    greetingCheck();
    super.onInit();
  }

  void greetingCheck() {
    var hour = DateTime.now().hour;
    if (hour <= 12) {
      greeting = 'Pagi';
    } else if ((hour > 12) && (hour <= 16)) {
      greeting = 'Siang';
    } else if ((hour > 16) && (hour < 20)) {
      greeting = 'Sore';
    } else {
      greeting = 'Malam';
    }
    isLoading = false;
    update();
  }

  void show() {
    isShow = !isShow;
    update();
  }

  void swap(int i) {
    index = i;
    update();
  }
}
