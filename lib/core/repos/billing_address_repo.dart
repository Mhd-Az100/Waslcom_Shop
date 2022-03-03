import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:waslcom/core/models/billing_address_dto.dart';
import 'package:waslcom/core/services/storage_service.dart';

import '../network.dart';

class BillingAddressRepo {
  ///---------------------------------------------------------------------------
  static final StorageService storage = Get.find();

  ///---------------------------------------------------------------------------
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  static Map<String, String> deleteHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${storage.getTokenInfo().token}'
  };

  static Map<String, String> authHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${storage.getTokenInfo().token}'
  };

  ///---------------------------------------------------------------------------

  ///End-points
  static const Addresses = "BillingAddress";
  static const Profile = "Profile";
  static const ProfileImage = "Profile/Image";

  static const my_Addresses = "BillingAddress/Mine";

  ///---------------------------------------------------------------------------
  ///Create billing address
  static Future<bool> createBillingAddressRequest(
      BillingAddressDto billingAddressDto) async {
    final http.Response response = await NetworkUtils.post(
        url: Addresses,
        body: json.encode(billingAddressDto.toJson()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.getTokenInfo().token}'
        });
    log(response.body.toString(), name: "createBillingAddressRequest response");
    if (response.statusCode == 201) {
      BotToast.showText(
          text: "تم اضافة عنوان الدفع بنجاح",
          duration: Duration(seconds: 4),
          align: Alignment.center);
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateBillingAddressRequest(
      {@required BillingAddressDto billingAddressDto, @required int id}) async {
    final http.Response response = await NetworkUtils.put(
        url: Addresses + "/$id",
        body: json.encode(billingAddressDto.toJson()),
        headers: authHeaders);
    log(response.body.toString(), name: "updateBillingAddressRequest response");
    if (response.statusCode > 199 || response.statusCode < 300) {
      BotToast.showText(
          text: "تم تحديث عنوان الدفع بنجاح",
          duration: Duration(seconds: 3),
          align: Alignment.center);
      return true;
    } else {
      return false;
    }
  }

  static Future<List<BillingAddressDto>> getAllBillingAddress() async {
    var _responseList = <dynamic>[];
    var _finalList = <BillingAddressDto>[];
    http.Response response = await NetworkUtils.get(
        url: my_Addresses + "?page=1&count=100", headers: authHeaders);
    if (response.statusCode == 200) {
      log(response.body.toString(), name: "getAllBillingAddress response");
      _responseList = json.decode(response.body);
      _finalList =
          _responseList.map((e) => BillingAddressDto.fromJson(e)).toList();
      return _finalList;
    } else {
      log(response.statusCode.toString(),
          name: "getAllBillingAddress api error");
      return _finalList;
    }
  }

  ///---------------------------------------------------------------------------
  static Future<bool> profileInfo(String name, String mobile) async {
    final http.Response response = await NetworkUtils.put(
        url: Profile,
        body: jsonEncode(<String, String>{
          'firstName': name,
          'phoneNumber': mobile,
        }),
        headers: authHeaders);
    log(response.body.toString(), name: "profile info response");
    if (response.statusCode > 199 || response.statusCode < 300) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getprofileImg() async {
    http.Response response =
        await NetworkUtils.get(url: Profile, headers: authHeaders);
    if (response.statusCode == 200) {
      log(response.body.toString(), name: "profile response");
      var data = jsonDecode(response.body);
      var idImg = data['profileImage']['id'];
      log(idImg.toString(), name: "profileImg Id api data");
      return idImg.toString();
    } else {
      log(response.statusCode.toString(), name: "profile api error");
      return null;
    }
  }

  static Future<bool> submitSubscription({File file, String filename}) async {
    ///MultiPart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(NetworkUtils.fixed_url + ProfileImage),
    );
    Map<String, String> headers = {
      'Authorization': 'Bearer ${storage.getTokenInfo().token}',
      "Content-type": "multipart/form-data"
    };
    request.files.add(
      http.MultipartFile(
        'file',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: filename,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);
    request.fields
        .addAll({"name": "test", "email": "test@gmail.com", "id": "12345"});
    print("request: " + request.toString());
    var res = await request.send();
    log(res.statusCode.toString(), name: "status image");
    if (res.statusCode == 413) {
      BotToast.showText(
          text: "الصورة كبيرة جدا",
          duration: Duration(seconds: 3),
          align: Alignment.center);
      return false;
    } else if (res.statusCode != 200) {
      BotToast.showText(
          text: "حدث خطأ",
          duration: Duration(seconds: 3),
          align: Alignment.center);
    } else if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
