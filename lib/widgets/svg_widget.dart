import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgWidget extends StatelessWidget {
  final String imgPath;
  final double imageWidth, imageHeight;
  final Color? color;

  SvgWidget({
    required this.imgPath,
   required this.imageWidth,
    required this.imageHeight,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return imgPath!=null
        ? SvgPicture.asset(
      imgPath,
      width: imageWidth,
      height: imageHeight,
      fit: BoxFit.contain,
      color: color,
    )
        : buildErrorWidget();
  }

  Widget buildErrorWidget() {
    return Container(

    );
  }
}