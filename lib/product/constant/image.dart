// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AppImages {
  notFound('not_found'),
  error('error');

  final String value;
  const AppImages(this.value);

  String get toSvg => "assets/images/$value.svg";
  SvgPicture toSvgImg(
    Color? color,
    double width,
    double height,
  ) =>
      SvgPicture.asset(
        toSvg,
        color: color,
        width: width,
        height: height,
      );

  String get toPng => "assets/images/$value.png";
  Image toPngImg(
    double width,
    double height,
  ) =>
      Image.asset(
        toPng,
        width: width,
        height: height,
      );
}
