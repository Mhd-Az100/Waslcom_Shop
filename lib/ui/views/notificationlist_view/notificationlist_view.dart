import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waslcom/ui/shared_files/app_colors.dart';
import 'package:waslcom/ui/views/notificationlist_view/notification_info.dart';
import 'package:waslcom/ui/views/notificationlist_view/notificationlist_controller.dart';
import 'package:waslcom/ui/views/store_views/main_store_view/main_store_view.dart';
import 'package:waslcom/ui/views/store_views/store_widgets/app_bars.dart';
import 'package:waslcom/ui/views/store_views/store_widgets/drawer/drawer_controller.dart';

class NotificationListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    NotificationListController controller =
        Get.find<NotificationListController>();

    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
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
          bottom: TabBar(
            indicatorColor: AppColors.actionIconsColor,
            labelColor: AppColors.actionIconsColor,
            tabs: <Widget>[
              Tab(
                text: 'خاصة',
                icon: Icon(
                  Icons.person,
                  color: AppColors.actionIconsColor,
                ),
              ),
              Tab(
                text: 'عامة',
                icon: Icon(
                  Icons.notifications,
                  color: AppColors.actionIconsColor,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            GetBuilder<NotificationListController>(builder: (_) {
              if (controller.notificationlist == null ||
                  controller.notificationlist.forYou == null) {
                return Container();
              } else {
                return ListView.builder(
                    itemCount: controller.notificationlist.forYou.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                color: controller.notificationlist.forYou[index]
                                            .status ==
                                        'Unread'
                                    ? Colors.yellow
                                    : AppColors.blueGrey.withOpacity(0.5),
                                spreadRadius: 0.5),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => NotificationInfo(
                                  message: controller
                                      .notificationlist.forYou[index].text,
                                  img: controller
                                      .notificationlist.forYou[index].imageUrl,
                                  title: controller
                                      .notificationlist.forYou[index].title,
                                ));
                            controller.readNotif(controller
                                .notificationlist.forYou[index].id
                                .toString());
                          },
                          child: ListTile(
                            leading: controller.notificationlist.forYou[index]
                                        .imageUrl ==
                                    null
                                ? Image.asset(
                                    'assets/pngs/alsamah_icon_luncher.png')
                                : Image.network(
                                    '''${controller.notificationlist.forYou[index].imageUrl}'''),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                      "${controller.notificationlist.forYou[index].title} ",
                                      style: GoogleFonts.cairo(
                                          fontSize: size.shortestSide / 25,
                                          color: AppColors.blue300Color,
                                          fontWeight: controller
                                                      .notificationlist
                                                      .forYou[index]
                                                      .status ==
                                                  'Unread'
                                              ? FontWeight.w800
                                              : FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end),
                                ],
                              ),
                            ),
                            subtitle: Text(
                                "${controller.notificationlist.forYou[index].text} ",
                                style: GoogleFonts.cairo(
                                    fontSize: size.shortestSide / 30,
                                    color: AppColors.blackColor,
                                    fontWeight: controller.notificationlist
                                                .forYou[index].status ==
                                            'Unread'
                                        ? FontWeight.w800
                                        : FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end),
                          ),
                        ),
                      );
                    });
              }
            }),
            GetBuilder<NotificationListController>(builder: (_) {
              if (controller.notificationlist == null ||
                  controller.notificationlist.topicNotifications == null) {
                return Container();
              } else {
                return ListView.builder(
                    itemCount:
                        controller.notificationlist.topicNotifications.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                color: controller.notificationlist
                                            .topicNotifications[index].status ==
                                        'Unread'
                                    ? Colors.orangeAccent.withOpacity(0.5)
                                    : AppColors.blueGrey.withOpacity(0.5),
                                spreadRadius: 0.5),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => NotificationInfo(
                                  message: controller.notificationlist
                                      .topicNotifications[index].text,
                                  img: controller.notificationlist
                                      .topicNotifications[index].imageUrl,
                                  title: controller.notificationlist
                                      .topicNotifications[index].title,
                                ));
                            controller.readNotif(controller
                                .notificationlist.topicNotifications[index].id
                                .toString());
                          },
                          child: ListTile(
                            leading: controller.notificationlist
                                        .topicNotifications[index].imageUrl ==
                                    null
                                ? Image.asset(
                                    'assets/pngs/alsamah_icon_luncher.png')
                                : Image.network(
                                    '''${controller.notificationlist.topicNotifications[index].imageUrl}'''),
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "${controller.notificationlist.topicNotifications[index].title} ",
                                  style: GoogleFonts.cairo(
                                      fontSize: size.shortestSide / 25,
                                      color: AppColors.blackColor,
                                      fontWeight: controller
                                                  .notificationlist
                                                  .topicNotifications[index]
                                                  .status ==
                                              'Unread'
                                          ? FontWeight.w800
                                          : FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end),
                            ),
                            subtitle: Text(
                                "${controller.notificationlist.topicNotifications[index].text} ",
                                style: GoogleFonts.cairo(
                                    fontSize: size.shortestSide / 30,
                                    color: AppColors.blackColor,
                                    fontWeight: controller
                                                .notificationlist
                                                .topicNotifications[index]
                                                .status ==
                                            'Unread'
                                        ? FontWeight.w800
                                        : FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end),
                          ),
                        ),
                      );
                    });
              }
            }),
          ],
        ),
      ),
    );
  }
}
