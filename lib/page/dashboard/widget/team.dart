import 'package:drawer/constants/constants.dart';
import 'package:drawer/page/dashboard/widget/team_info.dart';
import 'package:flutter/material.dart';

class team extends StatelessWidget {
  const team({
    Key? key,
  }) : super(key: key);

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
            "Project leaders",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),

          // data dari user + role manager
          teamInfo(
            title: "Jonathan",
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
          teamInfo(
            title: "Jonathan",
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
          teamInfo(
            title: "Jonathan",
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
          teamInfo(
            title: "Jonathan",
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
          teamInfo(
            title: "Jonathan",
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
          teamInfo(
            title: "Jonathan",
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
          teamInfo(
            title: "Jonathan",
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
          teamInfo(
            title: "Jonathan",
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
          teamInfo(
            title: "Jonathan",
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
        ],
      ),
    );
  }
}
