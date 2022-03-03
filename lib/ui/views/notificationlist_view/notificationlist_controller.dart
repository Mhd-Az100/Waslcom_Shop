import 'dart:developer';

import 'package:get/get.dart';
import 'package:waslcom/core/models/fcm_models.dart';
import 'package:waslcom/core/repos/notification_repo.dart';

class NotificationListController extends GetxController {
  var _notificationlist = new NotifiactionList();
  NotifiactionList get notificationlist => _notificationlist;
  void getAllNotification() async {
    try {
      var notiflst = await NotificationRepository.getNotificationList();
      _notificationlist = notiflst;
    } catch (e) {
      log(e.toString(), name: "getNotifiactionList controller  error");
    }
    update();
  }

  int countUnReadNoti;
  void getgetcountUnRead() async {
    try {
      var count = await NotificationRepository.getcountUnRead();
      countUnReadNoti = count;
    } catch (e) {
      log(e.toString(), name: "getUnreadNotificationsCount controller  error");
    }
    update();
  }

  void readNotif(String id) async {
    await NotificationRepository.readNotif(id);
    getgetcountUnRead();
    getAllNotification();
  }

  @override
  void onInit() async {
    super.onInit();
    getgetcountUnRead();
    getAllNotification();
  }
}
