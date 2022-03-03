import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waslcom/ui/shared_files/app_colors.dart';
import 'package:waslcom/ui/views/notificationlist_view/notificationlist_widget.dart';

class NotificationInfo extends StatelessWidget {
  String message;
  String title;

  String img;
  NotificationInfo({this.message, this.img, this.title});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: AppColors.blue200Color),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.actionIconsColor),
          onPressed: Get.back,
        ),
        title: Text(
          "الإشعارات".tr,
          style: GoogleFonts.cairo(
            color: AppColors.blue150Color,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => PhotoViewWidget(
                      img: img,
                    ));
              },
              child: img == null
                  ? Image.asset('assets/pngs/alsamah_icon_luncher.png')
                  : Image.network('$img'),
            ),
            SizedBox(
              height: 50,
            ),
            Text("$title ",
                style: GoogleFonts.cairo(
                    fontSize: size.shortestSide / 18,
                    color: AppColors.blue300Color,
                    fontWeight: FontWeight.w800),
                textAlign: TextAlign.center),
            Text("$message ",
                style: GoogleFonts.cairo(
                    fontSize: size.shortestSide / 25,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w800),
                textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
