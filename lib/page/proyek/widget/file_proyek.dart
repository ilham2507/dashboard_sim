import 'package:drawer/constants/constants.dart';
import 'package:drawer/page/karyawan/widget/filecard.dart';
import 'package:drawer/page/proyek/widget/filecard.dart';
import 'package:flutter/cupertino.dart';

class fileproyek extends StatelessWidget {
  const fileproyek({super.key});

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
          fileCardProyek(
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
          fileCardProyek(
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
        ],
      ),
    );
  }
}
