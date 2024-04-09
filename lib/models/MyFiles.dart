import 'package:drawer/constants/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    // this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Progress",
    numOfFiles: 5,
    svgSrc: "assets/icons/Documents.svg",
    color: primaryColor,
    // percentage: 35,
  ),
  CloudStorageInfo(
    title: "Finish",
    numOfFiles: 10,
    svgSrc: "assets/icons/drop_box.svg",
    color: primaryColor,
    // percentage: 78,
  ),
];
