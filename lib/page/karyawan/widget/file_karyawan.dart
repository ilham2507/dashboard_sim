import 'package:drawer/constants/constants.dart';
import 'package:drawer/page/dashboard/widget/team_info.dart';
import 'package:drawer/page/karyawan/widget/filecard.dart';
import 'package:drawer/page/sidebar/header.dart';
import 'package:flutter/cupertino.dart';

class fileKaryawan extends StatelessWidget {
  const fileKaryawan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Files",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          fileCard(
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
          fileCard(
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
        ],
      ),
    );
  }
}
