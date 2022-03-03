import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waslcom/core/enums.dart';
import 'package:waslcom/core/network.dart';
import 'package:waslcom/ui/shared_files/app_colors.dart';
import 'package:waslcom/ui/shared_widgets/shared_scaffold_widget.dart';
import 'package:waslcom/ui/views/profile_view/profile_view_controller.dart';
import 'package:waslcom/ui/views/profile_view/widgets/profile_widgets.dart';
import 'package:waslcom/ui/views/store_views/store_widgets/app_bars.dart';
import 'package:waslcom/ui/views/store_views/store_widgets/place_holders.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SharedScaffoldWidget.sharedScaffoldWidget(context, size,
        appBar: StoreAppBars.profileViewAppViewAppBar(context, size),
        // navBarEnum: NavBarEnum.ProfileView,
        body: GetBuilder<ProfileViewController>(
          init: ProfileViewController(),
          builder: (controller) {
            if (controller.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.connectionError) {
              return Center(
                child: NoConnectionWidget(),
              );
            } else {
              return Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: size.width,
                      height: size.height * 0.40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(25.0),
                              bottomLeft: Radius.circular(25.0)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 18,
                                spreadRadius: 1,
                                color: AppColors.grey.withOpacity(0.2))
                          ],
                          color: AppColors.whiteColor),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 14.5),
                            child: Divider(
                              thickness: 0.5,
                              color: AppColors.grey.withOpacity(0.2),
                            ),
                          ),
                          SizedBox(
                            height: size.height / 35,
                          ),
                          GestureDetector(
                            onTap: () =>
                                controller.postImg(ImageSource.gallery),
                            child: Stack(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFDADADA),
                                      shape: BoxShape.circle,
                                    ),
                                    width: 120,
                                    height: 140,
                                    margin: EdgeInsets.only(bottom: 0),
                                    child: controller.imageprofile == null &&
                                            controller.file == null
                                        ? CircleAvatar(
                                            child: SvgPicture.asset(
                                              "assets/svgs/user_avatar.svg",
                                              width: size.longestSide / 9,
                                              color: AppColors.blue150Color,
                                            ),
                                            backgroundColor:
                                                AppColors.grey50Color,
                                            radius: size.longestSide / 10,
                                          )
                                        : controller.filenull == false
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: FileImage(
                                                        controller.file,
                                                      ),
                                                      fit: BoxFit.cover),
                                                ),
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          NetworkUtils
                                                                  .MEDIA_API +
                                                              "${controller.imageprofile}"),
                                                      fit: BoxFit.cover),
                                                ),
                                              )),
                                Positioned(
                                    top: 0,
                                    left: 70,
                                    right: 0,
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF9DBD47),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.edit)))
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                                child: Column(
                              children: [
                                Text(
                                  controller.billingAddressDto?.userFullName ??
                                      "",
                                  style: GoogleFonts.cairo(
                                      color: AppColors.blue150Color,
                                      fontWeight: FontWeight.w300,
                                      fontSize: size.longestSide / 30),
                                ),
                                Text(
                                  controller.billingAddressDto?.userMobile ??
                                      "",
                                  style: GoogleFonts.cairo(
                                      color: AppColors.blue150Color,
                                      fontWeight: FontWeight.w300,
                                      fontSize: size.longestSide / 30),
                                )
                              ],
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 2,
                      child: BillingAddressWidgetForProfile(
                          billingAddressDto: controller.billingAddressDto,
                          addNewAddress: controller.navigateToAccountInfo))
                ],
              );
            }
          },
        ));
  }
}
