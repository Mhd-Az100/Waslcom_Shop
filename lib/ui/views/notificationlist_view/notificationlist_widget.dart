import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewWidget extends StatelessWidget {
  String img;
  PhotoViewWidget({this.img});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
        imageProvider: img == null
            ? AssetImage('assets/pngs/alsamah_icon_luncher.png')
            : NetworkImage('$img'),
      ),
    );
  }
}
