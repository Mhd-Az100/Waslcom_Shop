import 'dart:developer';

import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:waslcom/core/services/deviceId_service.dart';
import 'package:waslcom/core/services/storage_service.dart';
import 'dart:convert';
import '../network.dart';
import 'package:waslcom/core/models/fcm_models.dart';

class NotificationRepository {
  static final StorageService storage = Get.find<StorageService>();
  static final DeviceIdService deviceIdService = Get.find<DeviceIdService>();
  static final Notifiaction = "notifications";
  static final UnreadNotificationsCount =
      'Notifications/UnreadNotificationsCount';
  static final Markasread = 'notifications/markasread/';

  ///---------------------------------------------------------------------------
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  static Map<String, String> authHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${storage.getTokenInfo().token}'
  };

  ///---------------------------------------------------------------------------
  ///End-points

  static const FCMToken = "FCMToken";

  ///---------------------------------------------------------------------------
  ///Calls
  static Future<bool> sentFcmToken(String fcmToken) async {
    String _deviceId = await deviceIdService.getId();
    http.Response response = await NetworkUtils.post(
        url: FCMToken,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.getTokenInfo().token}'
        },
        body: json.encode({"token": fcmToken, "deviceID": _deviceId}));
    if (response.statusCode == 200) {
      log(response.body.toString(), name: "sentFcmToken response");
      return true;
    } else {
      log(response.statusCode.toString(), name: "Get sentFcmToken api error");
      return false;
    }
  }

  static Future<NotifiactionList> getNotificationList() async {
    var _finalList = new NotifiactionList();
    http.Response response =
        await NetworkUtils.get(url: Notifiaction, headers: authHeaders);
    if (response.statusCode == 200) {
      log(response.body, name: "getNotifiactionList response");
      var body = json.decode(response.body);
      _finalList = NotifiactionList.fromJson(body);
      return _finalList;
    } else {
      log(response.statusCode.toString(),
          name: "getNotifiactionList api error");
      return null;
    }
  }

  static Future<int> getcountUnRead() async {
    http.Response response = await NetworkUtils.get(
        url: UnreadNotificationsCount, headers: authHeaders);
    if (response.statusCode == 200) {
      log(response.body, name: "getUnreadNotificationsCount response");
      var body = json.decode(response.body);
      return body;
    } else {
      log(response.statusCode.toString(),
          name: "getUnreadNotificationsCount api error");
      return null;
    }
  }

  static Future readNotif(String id) async {
    http.Response response =
        await NetworkUtils.post(url: Markasread + id, headers: authHeaders);
    if (response.statusCode == 200) {
      log(response.body, name: "postRead response");
    } else {
      log(response.statusCode.toString(), name: "postRead api error");
      return null;
    }
  }
}
