import 'package:drawer/constants/responsive.dart';
import 'package:drawer/page/proyek/widget/widget%20detail%20proyek/filecarddetail.dart';
import 'package:flutter/material.dart';
import 'package:drawer/constants/constants.dart';

class filedetailproyek extends StatelessWidget {
  const filedetailproyek({Key? key}) : super(key: key);

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
          fileCardDetailProyek(
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
          fileCardDetailProyek(
            svgSrc: "assets/icons/media.svg",
            jabatan: "manager",
          ),
          SizedBox(height: defaultPadding),
          Center(
            child: Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {},
                icon: Icon(Icons.save),
                label: Text("Simpan"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
